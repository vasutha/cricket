class CreateBalls < ActiveRecord::Migration
  def up
    create_table :balls do |t|
      t.integer :over_id
      t.integer :player_id
      t.boolean :four , :default => false
      t.boolean :six , :default => false
      t.boolean :nb , :default => false
      t.boolean :wides , :default => false
      t.boolean :wicket , :default => false
      t.string :runs 
      t.timestamps
    end
  end
end
