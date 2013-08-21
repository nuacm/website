class AddTalkerAndTypeToEvent < ActiveRecord::Migration
  def change
    add_column :events, :talker, :string
    add_column :events, :type, :string
  end
end
