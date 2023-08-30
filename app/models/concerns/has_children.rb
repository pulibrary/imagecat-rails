# frozen_string_literal: true

# Create a module that has the 'children' method
module HasChildren
  extend ActiveSupport::Concern

  def children
    cards = SubGuideCard.where(parentid: sortid)
    cards.reject { |sgc| sgc.path&.start_with?('info') }
  end
end
