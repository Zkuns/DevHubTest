class BatchGenerateOrderJob < ApplicationJob
  queue_as :default

  def perform(combo, current_cut_off_time)
    # 如果截止时间变化，则任务取消
    return if current_cut_off_time != combo.current_cut_off_time

    # 查找未结束的order_group 生成订单
    order_group = combo.order_groups.find_by(end_at: nil)

    # 批量生成订单
    combo.generate_orders order_group

    # 结束上一段order_group
    order_group.update(end_at: combo.current_cut_off_time)

    # 生成新一段order_group
    OrderGroup.create(combo_id: combo.id, start_at: combo.current_cut_off_time)
  end
end
