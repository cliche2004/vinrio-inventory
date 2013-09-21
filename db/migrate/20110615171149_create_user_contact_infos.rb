class CreateUserContactInfos < ActiveRecord::Migration
  def self.up
    create_table :user_contact_infos do |t|
      t.text :data
      t.integer :contact_type_id
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :user_contact_infos
  end
end
