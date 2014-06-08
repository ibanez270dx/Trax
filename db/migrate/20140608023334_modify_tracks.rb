class ModifyTracks < ActiveRecord::Migration
  def change
    change_table :tracks do |t|
      t.remove :soundcloud_id, :soundcloud_uri, :soundcloud_permalink_url, :instrument, :time_signature
      t.string :audio_file_name
      t.string :audio_file_size
      t.string :audio_content_type
      t.string :audio_updated_at
    end
  end
end
