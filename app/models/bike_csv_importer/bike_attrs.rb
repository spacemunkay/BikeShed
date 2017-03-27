# Helper module to create various Bike instanct fields from a CSV row hash
class BikeCsvImporter
  module BikeAttrs
    def bike_attr_fields
      {
        shop_id:            'velocipede number',
        bike_purpose_id:    'program',
        #gone:               'gone',
        value:              'price',
        bike_brand_id:      'make',
        bike_model_id:      'model',
        model:              'model',
        bike_style_id:      nil,
        bike_condition_id:  nil,
        seat_tube_height:   nil,
        bike_wheel_size_id: nil,
        serial_number:      nil,
      }
    end

    def bike_attrs(bike_hash)
      bike_attr_fields.each_with_object({}) do |(model_field, csv_field), memo|
        memo[model_field] = send :"bike_attr_#{model_field}", clean_value(bike_hash[csv_field])
      end
    end

    def bike_attr_shop_id(value)
      value.to_i
    end

    def bike_attr_bike_purpose_id(value)
      map = {
          'SALE'      => /shop|as(-|\s+)is|safety\s*check/,
          'BUILDBIKE' => /build|bikes.*world/,
          'STORAGE'   => nil,
          'PARTS'     => /part|frame/,
          'SCRAP'     => /scrap|strip/,
      }

      default     = 'UNDETERMINED'
      test_value  = value.try :downcase
      value       = map.find { |_, regexp| regexp.try :match, test_value }.try :first

      cached_bike_purpose(value || default).id
    end

    def bike_attr_gone(value)
      %w{ yes yeah y }.include? value.try :downcase
    end

    def bike_attr_value(value)
      value.try(:gsub, /[$]/, '').try :to_i
    end

    def bike_attr_bike_brand(value, new_if_empty = false)
      value = 'Unknown' if !value || value =~ /\Aunknown/i
      cached_bike_brand value, new_if_empty
    end

    def bike_attr_bike_brand_id(value)
      bike_attr_bike_brand(value, false).try :id
    end

    def bike_attr_bike_model_id(value)
      return unless value
      cached_bike_model(value).try :id
    end

    def bike_attr_model(value)
      value if value && value !~ /unknown/i
    end

    def bike_attr_bike_style_id(_)
      @bike_style_other_cache ||= BikeStyle.find_by_style('OTHER').id
    end

    def bike_attr_bike_condition_id(_)
      @bike_condition_undertermined_cache ||= BikeCondition.find_by_condition('UNDETERMINED').id
    end

    def bike_attr_seat_tube_height(_)
      0
    end

    def bike_attr_bike_wheel_size_id(_)
      @bike_condition_wheel_size_undertermined_cache ||= BikeWheelSize.find_by_description('UNDETERMINED').id
    end

    def bike_attr_serial_number(_)
      'UNDETERMINED'
    end
  end
end
