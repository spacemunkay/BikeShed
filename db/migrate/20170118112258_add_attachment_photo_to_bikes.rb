class AddAttachmentPhotoToBikes < ActiveRecord::Migration
  def self.up
    change_table :bikes do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :bikes, :photo
  end
end
