# frozen_string_literal: true

# SubGuideCard class which each GuideCard belongs to
class SubGuideCard < ApplicationRecord
  belongs_to :guide_card
end
