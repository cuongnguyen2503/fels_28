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
  trans = "#{word}_trans"
  w = Word.create!(word: word, translation: trans, course_id: course.id)

  has_true_answer = false
  3.times do |n|
    true_answer = rand(2) == 1 if has_true_answer == false
    if true_answer == true
      has_true_answer = true
      choice = "#{word}_trans"
    else
      choice = "#{word}_choice_#{n + 1}"
    end
    Choice.create!(choice: choice, word_id: w.id, right_choice: has_true_answer)
  end
  if has_true_answer == false
    choice = "#{word}_trans"
  else
    choice = "#{word}_choice_4"
  end
  Choice.create!(choice: choice, word_id: w.id, right_choice: has_true_answer)
end

course = Course.find_by(id: 2)
30.times do |num|
  word = "word_#{num + 31}"
  trans = "#{word}_trans"
  w = Word.create!(word: word, translation: trans, course_id: course.id)

  has_true_answer = false
  3.times do |n|
    true_answer = rand(2) == 1 if has_true_answer == false
    if true_answer == true
      has_true_answer = true
      choice = "#{word}_trans"
    else
      choice = "#{word}_choice_#{n + 1}"
    end
    Choice.create!(choice: choice, word_id: w.id, right_choice: has_true_answer)
  end
  if has_true_answer == false
    choice = "#{word}_trans"
  else
    choice = "#{word}_choice_4"
  end
  Choice.create!(choice: choice, word_id: w.id, right_choice: has_true_answer)

end

course = Course.find_by(id: 3)
30.times do |num|
  word = "word_#{num + 61}"
  trans = "#{word}_trans"
  w = Word.create!(word: word, translation: trans, course_id: course.id)

  has_true_answer = false
  3.times do |n|
    true_answer = rand(2) == 1 if has_true_answer == false
    if true_answer == true
      has_true_answer = true
      choice = "#{word}_trans"
    else
      choice = "#{word}_choice_#{n + 1}"
    end
    Choice.create!(choice: choice, word_id: w.id, right_choice: has_true_answer)
  end
  if has_true_answer == false
    choice = "#{word}_trans"
  else
    choice = "#{word}_choice_4"
  end
  Choice.create!(choice: choice, word_id: w.id, right_choice: has_true_answer)

end

# Lessons
user = User.find_by(id: 1)
2.times do |n|
  n += 1
  course = Course.find_by(id: n)
  Lesson.create!(user_id: user.id, course_id: course.id)
end

# Learned words
len_arr = [20, 10]
2.times do |n|
  n += 1
  lesson = Lesson.find_by(id: n)
  words = Course.find_by(id: n).words.take(len_arr[n - 1])
  words.each do |word|
    choice = word.choices.sample
    LearnedWord.create!(lesson_id: lesson.id, word_id: word.id,
                        choice_id: choice.id)
  end
end
