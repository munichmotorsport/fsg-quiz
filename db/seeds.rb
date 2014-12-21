# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = User.new(:email => 'admin@test.de', :password => 'topsecret', :admin => true)
admin.save!
flo = User.new(:email => 'flo@test.de', :password => 'topsecret')
flo.save!
fee = User.new(:email => 'fee@test.de', :password => 'topsecret')
fee.save!

test_quiz = Quiz.new(:id => 1, :season => 2014, :category => "Electric", :production_ready => true)
test_quiz.save!
question1 = Question.new(:id => 1, :content => "Frage 1", :quiz_id => 1)
question1.save!
answer1 = Answer.new(:id => 1, :content => "falsch", :correct => false, :question_id => 1)
answer1.save!
answer2 = Answer.new(:id => 2, :content => "richtig", :correct => true, :question_id => 1)
answer2.save!
answer3 = Answer.new(:id => 3, :content => "falsch", :correct => false, :question_id => 1)
answer3.save!
answer4 = Answer.new(:id => 4, :content => "falsch", :correct => false, :question_id => 1)
answer4.save!
