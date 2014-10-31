class AddBallcountToBall < ActiveRecord::Migration
  def change
    add_column :balls, :ballcount, :string
  end
end
