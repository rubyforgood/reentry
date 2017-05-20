require 'open3'
require 'open-uri'

class DOJFetcher
  class << self
    def fetch(domain)
      uri = URI.parse(domain.url)
      csv_on_disk = create_csv_tempfile

      with_pdf_tempfile do |pdf_on_disk|
        write_pdf(uri, pdf_on_disk)
        write_csv(pdf_on_disk, csv_on_disk)
      end

      csv_on_disk.path
    end

    private

    def capture_tabula(pdf_on_disk)
      jar = Rails.root + 'tabula-0.9.2-jar-with-dependencies.jar'
      cmd = "java -jar #{jar} --spreadsheet #{pdf_on_disk.path} --pages all"
      Open3.capture3(cmd)
    end

    def create_csv_tempfile
      Tempfile.open('deleteme-doj.csv')
    end

    def normalize_tabula_output(out)
      out
        .lines
        .grep(/,/)
        .join
        .gsub(/\r(?!\n)/, ' ')
        .gsub(/\r\n/, "\n")
    end

    def with_pdf_tempfile
      Tempfile.open('doj.pdf') do |pdf_on_disk|
        pdf_on_disk.binmode
        yield pdf_on_disk
      end
    end

    def write_csv(pdf_on_disk, csv_on_disk)
      out, _err, _status = capture_tabula(pdf_on_disk)
      csv_on_disk.write(normalize_tabula_output(out))
    end

    def write_pdf(uri, pdf_on_disk)
      pdf_content = uri.open.read
      pdf_on_disk.write(pdf_content)
    end
  end
end
