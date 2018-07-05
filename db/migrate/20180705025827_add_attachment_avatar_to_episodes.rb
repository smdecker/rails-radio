class AddAttachmentAvatarToEpisodes < ActiveRecord::Migration[5.2]
  def self.up
    change_table :episodes do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :episodes, :avatar
  end
end
