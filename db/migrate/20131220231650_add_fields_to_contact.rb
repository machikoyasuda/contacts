class AddFieldsToContact < ActiveRecord::Migration
  def change
    add_column :contacts, :firstname, :string
    add_column :contacts, :lastname, :string
    add_column :contacts, :email_address, :string
  end
end
