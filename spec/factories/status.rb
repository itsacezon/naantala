require "app/models"
require "faker"

FactoryGirl.define do
  factory :status, class: Naantala::Models::Status do
    time { Faker::Time.between(Date.today, 2.days.from_now, :all)  }
    description { Faker::Lorem.sentence }
    status { "CAT #{rand(0..1) ? '3' : '4'}" }
    station { Faker::Address.street_name }
    bound { "#{rand(0..1) ? 'North' : 'South'} Bound" }
  end
end
