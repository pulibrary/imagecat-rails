# frozen_string_literal: true

# Adds a unique index for image_name to card_images so that `insert_all` for
# bulk ingest will work.
class AddCardImageUniqueIndex < ActiveRecord::Migration[7.0]
  def change
    add_index :card_images, :image_name, unique: true
  end
end
