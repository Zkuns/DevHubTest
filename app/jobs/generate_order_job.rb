class GenerateOrderJob < ApplicationJob
  queue_as :default

  def perform(subscription, order_group_id)
    # 查看是否下过单
    return if subscription.orders.find_by(order_group_id: order_group_id).present?

    # 生成订单
    subscription.generate_order order_group_id
  end
end
