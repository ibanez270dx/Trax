class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.references :user
      t.string  :title
      t.text    :description
      t.string  :instrument
      t.string  :time_signature
      t.integer :duration
      t.integer :soundcloud_id
      t.string  :soundcloud_uri
      t.string  :soundcloud_permalink_url
      t.timestamps
    end
  end
end
