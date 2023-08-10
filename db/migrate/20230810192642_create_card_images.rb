class CreateCardImages < ActiveRecord::Migration[7.0]
  def change
    create_table :card_images do |t|
      t.text :path
      t.text :image_name

      t.timestamps
    end
  end
end
