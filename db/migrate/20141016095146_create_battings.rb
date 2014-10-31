class CreateBattings < ActiveRecord::Migration
  def change
    create_table :battings do |t|
      t.integer :team_id
      t.integer :player_id
      t.integer :match_id
      t.string :dismissal_type
      t.string :dismissed_by
      t.string :order
      t.timestamps
    end
  end
end
