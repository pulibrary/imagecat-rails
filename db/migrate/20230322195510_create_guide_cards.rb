# frozen_string_literal: true

# a migration for GuideCards
class CreateGuideCards < ActiveRecord::Migration[7.0]
  def change
    create_table :guide_cards do |t|
      t.string :heading
      t.string :sortid
      t.string :path

      t.timestamps
    end
  end
end
