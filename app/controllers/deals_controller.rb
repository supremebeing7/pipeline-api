class DealsController < ApplicationController
  def index
    @chart = Deal.chart
  end
end
