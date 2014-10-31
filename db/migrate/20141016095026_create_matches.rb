class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :team1
      t.integer :team2
      t.integer :bat_first
      t.datetime :date
      t.string :mom
      t.string :place
      t.integer :team_won
      t.integer :toss_won

      t.timestamps
    end
  end
end
