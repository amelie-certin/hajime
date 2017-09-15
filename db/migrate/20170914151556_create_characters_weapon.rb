class CreateCharactersWeapon < ActiveRecord::Migration[5.1]
  def change
    create_table :characters_weapons do |t|
      t.belongs_to :weapon
      t.belongs_to :character
    end
  end
end
