FactoryGirl.define do
  factory :project do
    title {Faker::Hacker.verb + Faker::Hacker.noun}
    description {Faker::Hipster.paragraph}
    due_date {Faker::Date.between(1.days.from_now, 60.days.from_now)}
  end
end
