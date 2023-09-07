# frozen_string_literal: true

# index page pagenation = 10 records per page
class GuideCard < ApplicationRecord
  paginates_per 10
  include HasChildren

  def index_page
    number_to_check = id - 1
    (number_to_check / 10) + 1
  end
end
