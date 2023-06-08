# frozen_string_literal: true

# Create a module that has the 'children' method
module HasChildren
  extend ActiveSupport::Concern

  def children
    SubGuideCard.where(parentid: sortid)
  end
end
