# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

20.times do
  Project.create title: Faker::Hacker.verb + ' ' + Faker::Hacker.noun,
                 description: Faker::Hacker.say_something_smart + Faker::Hipster.paragraph(3),
                 due_date: Faker::Date.forward(60)
end
