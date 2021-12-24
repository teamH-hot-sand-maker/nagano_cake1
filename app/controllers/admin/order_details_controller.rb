class Admin::OrderDetailsController < ApplicationController
  def update
    @order_item = OrderItem.find(params[:id])
    @order_item.update(order_item_params)
    redirect_to request.referer
  end

  private
    def order_item_params
      params.require(:order_item).permit(:making_status)
    end
end