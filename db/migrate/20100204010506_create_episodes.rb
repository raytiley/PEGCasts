class CreateEpisodes < ActiveRecord::Migration
  def self.up
    create_table :episodes do |t|
      t.string :title
      t.text :embed_tag
      t.text :description
      t.text :notes
      t.boolean :published
      t.integer :series_id

      t.timestamps
    end
  end

  def self.down
    drop_table :episodes
  end
end
