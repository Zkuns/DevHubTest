FactoryBot.define do
  factory :combo do
    name { "combo1" }
    cut_off_week { Random.rand(0..6) }
    cut_off_time { Time.now }
  end
end
