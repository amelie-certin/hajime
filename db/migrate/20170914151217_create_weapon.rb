class CreateWeapon < ActiveRecord::Migration[5.1]
  def change
    create_table :weapons do |t|
      t.string :name
      t.integer :arms
      t.integer :legs
      t.integer :focus
      t.integer :power
    end
  end
end
