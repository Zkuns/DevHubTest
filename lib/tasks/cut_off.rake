namespace :cut_off do
  desc 'generate order and order_group for combos'
  task :combo_cut_off => :environment do |task, args|
    tomorrow_week = (DateTime.now + 1.day).strftime('%A').downcase
    Combo.where(cut_off_week: tomorrow_week).each do |combo|
      # 为明天截止的套餐在 cut_off 的时候批量生成订单
      BatchGenerateOrderJob.set(wait_until: combo.current_cut_off_time - 5.minutes).perform_later(combo, combo.cut_off_time)
    end
  end
end
