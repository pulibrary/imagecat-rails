# frozen_string_literal: true

require 'rails_helper'

# This doesn't really test anything, it just demonstrates that coverage works
# and serves as an example model test.
RSpec.describe ApplicationRecord do
  it 'is a class' do
    expect(ApplicationRecord).to be_a Class
  end
end
