# frozen_string_literal: true

# db migration for GuideCard and SubGuide association
class AddGuideCardIdToSubGuideCard < ActiveRecord::Migration[7.0]
  def change
    change_table :sub_guide_cards do |t|
      t.belongs_to :guide_card
    end
  end
end
