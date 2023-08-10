# frozen_string_literal: true

# SubGuideCards provide hierarchical structure between GuideCards and catalog cards
class SubGuideCard < ApplicationRecord
  # A sub_guide_card parent can either be a GuideCard or a SubGuideCard
  def parent
    GuideCard.find_by(sortid: parentid) || SubGuideCard.find_by(sortid: parentid)
  end
  include HasChildren
  def url
    'https://puliiif.princeton.edu/iiif/2/imagecat-disk5-0338-A5977-0000.0073/full/,500/0/default.jpg'
  end
end
