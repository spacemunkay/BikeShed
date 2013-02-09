class TaskList < ActiveRecord::Base
  attr_accessible :item_id, :item_type, :name

  belongs_to :item, :polymorphic => true
  has_many :tasks

  def to_s
    self.name
  end
end
