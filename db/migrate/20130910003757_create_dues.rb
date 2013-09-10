class CreateDues < ActiveRecord::Migration
  def change
    create_table :dues do |t|
      t.integer :amount
      t.belongs_to :member

      t.timestamps
    end
  end
end
