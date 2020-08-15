require "rails_helper"
require 'rake'
Rails.application.load_tasks

describe "combo rake" do
  let(:combo) { create(:combo, cut_off_week: Time.now.tomorrow.wday, cut_off_time: Time.now) }
  let(:user) { create(:user) }
  let!(:subscription) { create(:subscription, combo: combo, user: user) }
  it "batch generate order" do
    ActiveJob::Base.queue_adapter = :test
    expect {
      Rake::Task["cut_off:combo_cut_off"].invoke
    }.to have_enqueued_job(BatchGenerateOrderJob)
  end
end
