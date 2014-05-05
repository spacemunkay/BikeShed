json.time_entries [@time_entry] do |time_entry|
  json.array! time_entry
  #json.set! :href, api_time_entry_path(time_entry)
end
