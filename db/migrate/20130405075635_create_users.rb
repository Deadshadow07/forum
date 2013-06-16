# -*- encoding : utf-8 -*-
class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :crypted_password
      t.string :salt
      t.string :email
      t.integer :role
      t.string :font

      t.timestamps
    end
  end
end
