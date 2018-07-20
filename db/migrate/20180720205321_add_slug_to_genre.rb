class AddSlugToGenre < ActiveRecord::Migration[5.2]
  def change
    add_column :genres, :slug, :string
  end
end
