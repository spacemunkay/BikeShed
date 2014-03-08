json.task_lists [@task_list] do |tl|
  json.array! tl
  json.links do
    json.bike do
      json.href api_bike_path(tl.item)
      json.id tl.item_id
    end
    json.tasks tl.tasks do |task|
      json.id task.id
      json.done task.done
      json.notes task.notes
      json.task task.task
    end
  end
end
