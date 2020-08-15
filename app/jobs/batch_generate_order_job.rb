class BatchGenerateOrderJob < ApplicationJob
  queue_as :default

  def perform(combo, current_cut_off_time)
    # 如果截止时间变化，则任务取消
    return if current_cut_off_time != combo.current_cut_off_time

    # 查找未结束的order_group 生成订单
    order_group = combo.order_groups.find_by(end_at: nil)

    # 批量生成订单
    combo.subscriptions.each do |subscription|
      # 查看是否下过单，给之前订阅成功却因为余额不足的而没有生成订单的订阅再次尝试是否可以生成订单
      return if subscription.orders.find_by(order_group_id: order_group_id).present?

      # 生成订单
      subscription.generate_order order_group_id
    end

    # 结束上一段order_group
    order_group.update(end_at: combo.current_cut_off_time)

    # 生成新一段order_group
    OrderGroup.create(combo_id: combo.id, start_at: combo.current_cut_off_time)
  end
end
