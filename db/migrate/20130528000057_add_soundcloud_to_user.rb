class AddSoundcloudToUser < ActiveRecord::Migration
  def change

    change_table :users do |t|
      t.string :soundcloud_id
    end
  end
end
