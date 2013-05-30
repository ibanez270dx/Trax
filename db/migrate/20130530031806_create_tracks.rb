class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.references :user
      t.string :title
      t.timestamps
    end
  end
end
