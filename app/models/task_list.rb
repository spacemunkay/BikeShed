require 'yaml'

class TaskList < ActiveRecord::Base
  attr_accessible :item_id, :item_type, :name

  belongs_to :item, :polymorphic => true
  has_many :tasks, order: "id ASC"

  after_save :create_default_bike_tasks

  @@default_bike_tasks = YAML::load(File.open(File.join( Rails.root, "db", "defaults", "bike_tasks.yml")))["tasks"]

  def to_s
    self.name
  end

  def create_default_bike_tasks
    @@default_bike_tasks.each do |task|
      self.tasks.create( task: task, done: false)
    end
  end
end
