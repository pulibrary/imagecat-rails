# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InfoCard, type: :model do
  it 'has a path and html value' do
    info_card = InfoCard.create(path: 'A', html: 'entries: <ol><li> selections </li></ol>')
    expect(info_card.path).to be_a String
    expect(info_card.html).to be_a String
  end
end
