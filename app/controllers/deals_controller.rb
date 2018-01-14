class DealsController < ApplicationController
  def index
    @deals = Deal.all
    @chart = Deal.chart
  end
end
