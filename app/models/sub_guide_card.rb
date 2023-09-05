# frozen_string_literal: true

# SubGuideCards provide hierarchical structure between GuideCards and catalog cards
class SubGuideCard < ApplicationRecord
  # A sub_guide_card parent can either be a GuideCard or a SubGuideCard
  paginates_per 5
  def parent
    GuideCard.find_by(sortid: parentid) || SubGuideCard.find_by(sortid: parentid)
  end
  include HasChildren
  def image_urls; end
end
