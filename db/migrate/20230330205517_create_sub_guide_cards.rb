# frozen_string_literal: true

class CreateSubGuideCards < ActiveRecord::Migration[7.0]
  def change
    create_table :sub_guide_cards do |t|
      t.string :heading
      t.string :sortid
      t.string :parentid
      t.string :path

      t.timestamps
    end
  end
end
