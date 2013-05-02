class AddTypeToMember < ActiveRecord::Migration
  def change
    add_column :members, :type, :string
  end
end
