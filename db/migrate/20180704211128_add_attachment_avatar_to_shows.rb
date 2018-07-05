class AddAttachmentAvatarToShows < ActiveRecord::Migration[5.2]
  def self.up
    change_table :shows do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :shows, :avatar
  end
end
