class CreateResetKeys < ActiveRecord::Migration
  def change
    create_table :reset_keys do |t|
      t.datetime :valid_until
      t.string :key

      t.timestamps
    end
  end
end
