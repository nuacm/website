class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :full_name
      t.string :email

      t.timestamps
    end
  end
end
