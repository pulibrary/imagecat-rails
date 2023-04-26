# frozen_string_literal: true

# index page pagenation = 10 records per page 
class GuideCard < ApplicationRecord
  paginates_per 10
end
