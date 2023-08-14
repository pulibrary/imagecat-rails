# frozen_string_literal: true

# Controller for SubGuideCards
class SubGuideCardsController < ApplicationController
  def index; end

  def show
    @sub_guide_card = SubGuideCard.find(params[:id])
  end
end
