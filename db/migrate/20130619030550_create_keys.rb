class CreateKeys < ActiveRecord::Migration
  def change
    create_table :keys do |t|
      t.string :token
      t.datetime :expires_on
      t.boolean :is_locked
      t.references :keyable, :polymorphic => true
      t.string :key_type

      t.timestamps
    end
  end
end
