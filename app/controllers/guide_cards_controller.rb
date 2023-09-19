# frozen_string_literal: true

# controller for GuideCards

# Note that these cards must be ordered by id, not heading. This is
# counterintuitive, because it results in a thing that might not look like
# alphabetical order. However, it is the order of the card catalog, which is wanted by the stakeholder.

class GuideCardsController < ApplicationController
  def index
    @guide_cards = GuideCard.order(:id).page(params[:page])
  end

  def search
    @match = GuideCard.search_result(params[:search_term])
    @guide_cards =
      if params[:page].present?
        GuideCard.order(:id).page(params[:page])
      else
        GuideCard.order(:id).page(@match.index_page)
      end
  end

  def show
    @guide_card = GuideCard.find(params[:id])
    @sub_guide_cards = @guide_card.children
  end
end
