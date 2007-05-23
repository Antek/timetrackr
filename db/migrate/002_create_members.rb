class CreateMembers < ActiveRecord::Migration
  def self.up
    create_table "members", :force => true do |t|
      t.column :group_id,                  :integer
      t.column :login,                     :string
      t.column :fullname,                  :string
      t.column :email,                     :string
      t.column :full_name,                 :string
      t.column :crypted_password,          :string, :limit => 40
      t.column :salt,                      :string, :limit => 40
      t.column :created_at,                :datetime
      t.column :updated_at,                :datetime
      t.column :remember_token,            :string
      t.column :remember_token_expires_at, :datetime      
    end
  end

  def self.down
    drop_table "members"
  end
end