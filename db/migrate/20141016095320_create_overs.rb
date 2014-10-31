class CreateOvers < ActiveRecord::Migration
  def change
    create_table :overs do |t|
      t.integer :team_id
      t.integer :player_id
      t.integer :match_id
      t.string :count

      t.timestamps
    end
  end
end
