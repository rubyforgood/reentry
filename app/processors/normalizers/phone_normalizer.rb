class PhoneNormalizer
  PHONE_FORMATS = {
    'XXXXXXXXXX' => /\d{10}/,
  }.freeze

  class << self
    def normalize(phone_data_string)
      numbers_array = phone_data_string.split('/')

      numbers_array.map do |num|
        partials     = num.split('x')
        phone_number = PhoneNumber.new(partials)

        format_phone_number(phone_number)
      end
    end

    private

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
      stripped_number = phone_number.gsub(/\D/, '')

      case stripped_number
      when formatted_as['XXXXXXXXXX'] then hyphenate(stripped_number)
      else
        fail_phone_format(phone_number)
        phone_number
      end
    end

    def hyphenate(number)
      if number.length > 10
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
