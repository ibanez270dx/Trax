class CreateTracksTragsJoinTable < ActiveRecord::Migration
  def change
    create_table :tags_tracks do |t|
      t.integer :tag_id
      t.integer :track_id
    end
  end
end
