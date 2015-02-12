# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Users
User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin:     true)

30.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name,
              email: email,
              password:              password,
              password_confirmation: password)
end

50.times do
  name = Faker::Lorem.sentence(1)
  content = Faker::Lorem.sentence(5)
  Course.create!(name: name, content: content)
end

# Following relationships
users = User.all
user  = users.first
following = users[2..30]
followers = users[3..20]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

# Words
course = Course.find_by(id: 1)
30.times do |num|
  word = "word_#{num + 1}"
  translation = "#{word}_trans"
  Word.create!(word: word, translation: translation, course_id: course.id)
end
course = Course.find_by(id: 2)
30.times do |num|
  word = "word_#{num + 31}"
  translation = "#{word}_trans"
  Word.create!(word: word, translation: translation, course_id: course.id)
end

# Learn words
user = User.find_by(id: 1)
10.times do |word_id|
  word_id = word_id + 1
  LearnedWord.create!(user_id: user.id, word_id: word_id)
end
