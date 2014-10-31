class AddBallcountToOver < ActiveRecord::Migration
  def change
    add_column :overs, :ballcount, :integer
  end
end
