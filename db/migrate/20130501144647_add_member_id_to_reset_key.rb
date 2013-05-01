class AddMemberIdToResetKey < ActiveRecord::Migration
  def change
    add_column :reset_keys, :member_id, :integer
  end
end
