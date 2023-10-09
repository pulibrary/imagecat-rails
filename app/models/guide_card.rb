# frozen_string_literal: true

# index page pagenation = 10 records per page
class GuideCard < ApplicationRecord
  paginates_per 10
  include HasChildren

  # First, try to find an exact match. Otherwise, find the closest match.
  def self.search_result(term)
    match = GuideCard.find_by('heading ilike ?', term)
    return match if match.present?

    GuideCard.where('heading < ?', term).order(heading: :desc).limit(1).first
  end

  # Calculate which page of the full index list contains the given GuideCard.
  def index_page
    number_to_check = id - 1
    (number_to_check / 10) + 1
  end
end
