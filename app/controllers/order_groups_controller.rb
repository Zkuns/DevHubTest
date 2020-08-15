class OrderGroupsController < ApplicationController
  before_action :set_order_group, only: [:show]

  def show
    @orders = @order_group.orders
  end

  private

  def set_order_group
    @order_group = OrderGroup.find(params[:id])
  end
end
