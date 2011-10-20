class CreateFactions < ActiveRecord::Migration
  def change
    create_table :factions do |t|
      t.string :name
      t.integer :influence_threshold
      t.timestamps
    end
  end
end
