class AddPasswordResetToMembers < ActiveRecord::Migration
  def change
    add_column :members, :password_reset_token, :string
    add_column :members, :password_reset_sent_at, :datetime
  end
end
