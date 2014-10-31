class AddMatchIdToBall < ActiveRecord::Migration
  def change
    add_column :balls, :match_id, :integer
  end
end
