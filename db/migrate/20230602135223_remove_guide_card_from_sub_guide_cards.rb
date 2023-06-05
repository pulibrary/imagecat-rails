# frozen_string_literal: true

# db migration for revert of belong_to association with GuideCard
class RemoveGuideCardFromSubGuideCards < ActiveRecord::Migration[7.0]
  def change
    remove_column :sub_guide_cards, :guide_card_id, :bigint
  end
end
