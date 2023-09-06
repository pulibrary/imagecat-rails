# frozen_string_literal: true

# Controller for SubGuideCards
class SubGuideCardsController < ApplicationController
  def index; end

  def show
    @sub_guide_card = SubGuideCard.find(params[:id])
    @card_images = CardImage.where(path: @sub_guide_card.path).page(params[:page])
  end
end
