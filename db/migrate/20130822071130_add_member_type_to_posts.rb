class AddMemberTypeToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :member_type, :string
  end
end
