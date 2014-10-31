class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.integer :match_id

      t.timestamps
    end
  end
end
