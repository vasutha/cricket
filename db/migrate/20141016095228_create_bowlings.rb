class CreateBowlings < ActiveRecord::Migration
  def change
    create_table :bowlings do |t|
      t.integer :team_id
      t.integer :player_id
      t.integer :match_id
      t.string :order

      t.timestamps
    end
  end
end
