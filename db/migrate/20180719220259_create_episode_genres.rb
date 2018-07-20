class CreateEpisodeGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :episode_genres do |t|
      t.integer :episode_id
      t.integer :genre_id
      
      t.timestamps
    end
  end
end
