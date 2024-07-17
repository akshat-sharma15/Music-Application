class CreateSong < ActiveRecord::Migration[7.0]
  def change
    create_table :songs do |t|
      t.string :name
      t.string :movie
      t.text :lyrics
      t.timestamps
    end
  end
end
