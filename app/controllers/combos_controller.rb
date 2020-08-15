class CombosController < ApplicationController
  before_action :set_combo, only: [:show, :subscribe]

  def index
    @combos = Combo.all.order(created_at: :desc)

    # 最近订阅的哪些热门套餐
    @hottest_combo = Subscription.where('created_at > ?', Time.now.beginning_of_week - 7.days).order('count(*) desc').group(:combo_id).count
    @hottest = Combo.where(id: @hottest_combo.map{|id, _| id })
  end

  def show
    @order_groups = @combo.order_groups
  end

  def subscribe
    subscription = Subscription.new(combo: @combo, user: current_user)
    unless subscription.save
      flash[:error] = subscription.errors.full_messages
    end
    redirect_to combos_path
  end

  private

  def set_combo
    @combo = Combo.find(params[:id])
  end

  def set_subscribetion
    @subscribetion = Subscription.find_by(combo_id: params[:id], user_id: current_user.id)
  end
end
