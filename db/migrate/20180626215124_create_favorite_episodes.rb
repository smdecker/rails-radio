class CreateFavoriteEpisodes < ActiveRecord::Migration[5.2]
  def change
    create_table :favorite_episodes do |t|
    	t.integer :episode_id
      t.integer :user_id
      
      t.timestamps
    end
  end
end
