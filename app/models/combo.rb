class Combo < ApplicationRecord
  enum cut_off_week: DateTime::DAYS_INTO_WEEK

  has_many :order_groups
  has_many :subscriptions

  after_update :time_change
  after_create :time_change

  def time_change
    # 如果是修改了当天的截止时间则需要重新执行任务
    if (DateTime.now.strftime('%A') == week) && previous_changes[:cut_off_time]
      BatchGenerateOrderJob.set(wait_until: combo.current_cut_off_time).perform_later(combo, combo.current_cut_off_time)
    end
  end

  def current_cut_off_time
    DateTime.parse(cut_off_week).change(hour: cut_off_time.hour, min: cut_off_time.min)
  end
end
