class CreateTableSongs < ActiveRecord::Migration[7.0]
  def change
    create_table :songs do |t|
      t.string :name
      t.string :movie
      t.text :lyrics
      t.references :commentable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
