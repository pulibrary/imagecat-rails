# frozen_string_literal: true

# controller for GuideCards
class GuideCardsController < ApplicationController
  def index
    @guide_cards = GuideCard.order(:heading).page(params[:page])
  end

  def search
    @match = GuideCard.search_result(params[:search_term])
    @guide_cards =
      if params[:page].present?
        GuideCard.order(:heading).page(params[:page])
      else
        GuideCard.order(:heading).page(@match.index_page)
      end
  end

  def show
    @guide_card = GuideCard.find(params[:id])
    @sub_guide_cards = @guide_card.children
  end
end
