class AddResumeToFight < ActiveRecord::Migration[5.1]
  def change
    add_column :fights, :resume, :text
  end
end
