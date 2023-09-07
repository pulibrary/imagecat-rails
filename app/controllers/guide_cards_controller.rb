# frozen_string_literal: true

# controller for GuideCards
class GuideCardsController < ApplicationController
  def index
    @guide_cards = GuideCard.page(params[:page])
  end

  def search
    @exact_match = GuideCard.find_by(heading: params[:search_term])
    @guide_cards = GuideCard.page(1)
  end

  def show
    @guide_card = GuideCard.find(params[:id])
    @sub_guide_cards = @guide_card.children
  end
end
