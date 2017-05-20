class PhoneNormalizer
  PHONE_FORMATS = {
    'X-XXX-XXX-XXXX' => /\d{1}-\d{3}-\d{3}-\d{4}/,
    'XXX-XXX-XXXX'   => /\d{3}-\d{3}-\d{4}/,
    '(XXX)XXX-XXXX'  => /\(.*?\d{3}\)\d{3}-\d{4}/,
    'XXX.XXX.XXXX'   => /\d{3}\.\d{3}\.\d{4}/,
    'XXXXXXXXXX'     => /\d{10}/,
  }.freeze

  class << self
    def normalize(number_string)
      partials     = number_string.split(' x')
      phone_number = PhoneNumber.new(partials)

      if phone_number.has_extension?
        reformatted_string_with_extension phone_number
      else
        reformat_string phone_number.number
      end
    end

    private

    def reformatted_string_with_extension(phone_number)
      "#{reformat_string(phone_number.number)} ext: #{phone_number.extension}"
    end

    def reformat_string(phone_number, formatted_as: PHONE_FORMATS)
      stripped_number = phone_number.gsub(/\D/, '')

      case stripped_number
      when formatted_as['X-XXX-XXX-XXXX'] then stripped_number
      when formatted_as['XXX-XXX-XXXX']   then stripped_number
      when formatted_as['(XXX)XXX-XXXX']  then stripped_number.tr('(', '').tr(')', '-')
      when formatted_as['XXX.XXX.XXXX']   then stripped_number.tr('.',  '-')
      when formatted_as['XXXXXXXXXX']     then hyphenate(stripped_number)
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
    def number
      partials.first
    end

    def extension
      partials.try(:[], 1)
    end

    def has_extension?
      partials.length > 1
    end
  end
end
