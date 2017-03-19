class BikeCsvImporter
  module BikeAttrs
    def bike_attr_fields
      %i{ shop_id bike_purpose_id value bike_brand_id bike_model_id model bike_style_id bike_condition_id seat_tube_height bike_wheel_size_id serial_number }
    end

    def bike_attrs(bike_hash)
      bike_attr_fields.each_with_object({}) do |field, memo|
        memo[field] = send :"bike_attr_#{ field }", bike_hash
      end
    end

    def bike_attr_shop_id(bike_hash)
      bike_hash['velocipede number'].to_i
    end

    def bike_attr_bike_purpose_id(bike_hash)
      map = {
          'SALE'      => /shop|as(-|\s+)is|safety\s*check/,
          'BUILDBIKE' => /build|bikes.*world/,
          'STORAGE'   => nil,
          'PARTS'     => /part|frame/,
          'SCRAP'     => /scrap|strip/,
      }

      default     = 'UNDETERMINED'
      test_value  = clean_value(bike_hash['program']).try :downcase
      value       = map.find { |_, regexp| regexp.try :match, test_value }.try :first

      cached_bike_purpose(value || default).id
    end

    def bike_attr_gone(bike_hash)
      %w{ yes yeah y }.include? clean_value(bike_hash['gone']).try :downcase
    end

    def bike_attr_value(bike_hash)
      clean_value(bike_hash['price']).try(:gsub, /[$]/, '').try :to_i
    end

    def bike_attr_bike_brand_id(bike_hash)
      brand = clean_value(bike_hash['make'])
      return unless brand
      cached_bike_brand(brand).try :id
    end

    def bike_attr_bike_model_id(bike_hash)
      model = clean_value(bike_hash['model'])
      return unless model
      cached_bike_model(model).try :id
    end

    def bike_attr_model(bike_hash)
      model = clean_value bike_hash['model']
      model unless model =~ /unknown/i
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
