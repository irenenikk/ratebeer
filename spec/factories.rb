FactoryGirl.define do
  sequence :username do |i|
    "user#{i}"
  end

  factory :user do
    username "Pekka"
    password "Salsa1"
    password_confirmation "Salsa1"
  end

  factory :rating do
    score 10
  end

  factory :rating2, class: Rating do
    score 20
  end

  factory :brewery do
    name "brewery"
    year 1900
  end

  factory :beer do
    name "beer"
    brewery
    style :style
  end
end
