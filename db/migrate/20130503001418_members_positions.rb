class MembersPositions < ActiveRecord::Migration
  def change
    create_table :members_positions, :id => false do |t|
      t.belongs_to :member
      t.belongs_to :position
    end
  end
end
