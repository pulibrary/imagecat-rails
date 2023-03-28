# frozen_string_literal: true

# controller for GuideCards
class GuideCardsController < ApplicationController
  def index; end

  def show
    @guide_card = GuideCard.find(params[:id])
  end
end
