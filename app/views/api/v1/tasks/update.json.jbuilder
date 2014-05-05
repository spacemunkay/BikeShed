json.tasks [@tasks.map{|x| x[:record]}] do |task|
  json.array! task
end
