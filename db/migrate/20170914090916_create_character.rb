class CreateCharacter < ActiveRecord::Migration[5.1]
  def change
    create_table :characters do |t|
      t.string :name
      t.integer :arms
      t.integer :legs
      t.integer :strength
      t.integer :defense
      t.integer :health
      t.integer :focus
      t.integer :speed
      t.integer :charisma
    end
   add_attachment :characters, :avatar
  end
end
