class AddPasswordDigestToMember < ActiveRecord::Migration
  def change
    add_column :members, :password_digest, :string
  end
end
