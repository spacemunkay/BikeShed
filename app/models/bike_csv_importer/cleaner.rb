class BikeCsvImporter
  module Cleaner
    def clean_value(value)
      value_or_nil strip_value(value)
    end

    def strip_value(value)
      value.try(:strip).try(:gsub, /\n|\r/, '')
    end

    def value_or_nil(value)
      return value unless ['?', 'n/a', 'missing', 'unknown', ''].include? value.try(:downcase)
    end
  end
end
