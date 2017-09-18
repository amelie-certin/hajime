class CreateFight < ActiveRecord::Migration[5.1]
  def change
    create_table :fights do |t|
      t.integer :winner
    end
    add_reference :fights, :player, foreign_key: true
    add_reference :fights, :opponent, foreign_key: true
  end
end
