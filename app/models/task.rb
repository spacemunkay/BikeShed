class Task < ActiveRecord::Base
  attr_accessible :task, :notes, :done, :task_list_id

  belongs_to :task_list

  def to_s
    self.task
  end
end
