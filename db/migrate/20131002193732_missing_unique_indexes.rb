class MissingUniqueIndexes < ActiveRecord::Migration
  def change
    add_index :keys, :token, :unique => true
    add_index :members, :email, :unique => true
  end
end
