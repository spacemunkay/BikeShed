json.bikes [@bike] do |bike|
  json.array! bike
  json.set! :href, api_bike_path(bike)
end
