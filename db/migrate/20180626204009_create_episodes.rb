class CreateEpisodes < ActiveRecord::Migration[5.2]
  def change
    create_table :episodes do |t|
    	t.string :title
    	t.string :description
    	t.date :air_date
    	t.string :slug
    	t.integer :show_id
    	t.integer :user_id

      t.timestamps
    end
  end
end
