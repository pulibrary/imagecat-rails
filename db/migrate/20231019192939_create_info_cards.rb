class CreateInfoCards < ActiveRecord::Migration[7.0]
  def change
    create_table :info_cards do |t|
      t.string :path
      t.text :html

      t.timestamps
    end
  end
end
