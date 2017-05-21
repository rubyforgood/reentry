class PhoneNormalizer
  PHONE_FORMATS = {
    'Digits Only' => /\d{10}/,
    'Alphanumeric' => /\d{6}\D{4}\d{4}/,
  }.freeze

  class << self
    def normalize(phone_data_string)
      return [] if phone_data_string.blank?
      numbers_array = split_phone_data(phone_data_string)

      numbers_array.map do |num|
        partials     = num.split('ext')
        phone_number = PhoneNumber.new(partials)

        format_phone_number(phone_number)
      end
    end

    private

    def split_phone_data(data_string)
      return data_string.split('/') if data_string.include?('/')
      return data_string.split(';') if data_string.include?(';')

      [data_string]
    end

    def format_phone_number(phone_number)
      if phone_number.has_extension?
        reformat_string_with_extension(phone_number)
      else
        reformat_string(phone_number.partials.first)
      end
    end

    def reformat_string_with_extension(phone_number)
      stripped_extension = phone_number.extension.gsub(/\D/, '')
      "#{reformat_string(phone_number.partials.first)} ext: #{stripped_extension}"
    end

    def reformat_string(phone_number, formatted_as: PHONE_FORMATS)
      stripped_number = phone_number
        .gsub(/.M/, '')
        .gsub(/\W/, '')

      case stripped_number
      when formatted_as['Digits Only']  then hyphenate(stripped_number)
      when formatted_as['Alphanumeric'] then hyphenate(stripped_number, with_word: true)
      else
        fail_phone_format(phone_number)
        phone_number
      end
    end

    def hyphenate(number, with_word: false)
      if with_word
        number.split('').insert(3, '-').insert(7, '-').insert(12, ' (').insert(17, ')').join('')
      elsif number.length > 10
        number.split('').insert(1, '-').insert(5, '-').insert(9, '-').join('')
      else
        number.split('').insert(3, '-').insert(7, '-').join('')
      end
    end

    def fail_phone_format(phone_number)
      message = "Unhandled phone number format received: #{phone_number}"
      Rails.logger.warn message
    end
  end

  PhoneNumber = Struct.new(:partials) do
    def extension
      partials.try(:[], 1)
    end

    def has_extension?
      partials.length > 1
    end
  end
end
