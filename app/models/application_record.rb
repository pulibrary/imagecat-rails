# frozen_string_literal: true

# The ApplicationRecord model will map objects onto the database
class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
end
