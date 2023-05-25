# frozen_string_literal: true

# SubGuideCard class which each GuideCard belongs to
# Line 6 is a validation. The validation states that in order for a sub_guide to save it needs an associated guide_card
class SubGuideCard < ApplicationRecord
  belongs_to :guide_card
end
