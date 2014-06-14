class ModifyUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.rename :login, :email
      t.remove :soundcloud_id
    end
  end
end
