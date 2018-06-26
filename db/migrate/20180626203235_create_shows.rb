class CreateShows < ActiveRecord::Migration[5.2]
  def change
    create_table :shows do |t|
    	t.string :title
      t.string :description
      t.string :location
      t.string :link
      t.string :twitter
      t.string :facebook
      t.string :soundcloud
      t.string :slug

      t.timestamps
    end
  end
end
