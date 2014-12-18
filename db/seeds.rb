# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             # admin: true,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

Subreddit.create!(subname: 'test')

users = User.order(:created_at).take(6)
50.times do |n|
	title = "Title-#{n+1}"
	link = "http://www.google.com"
  subreddit = "test"
  body = Faker::Lorem.sentence(5)
  users.each do |user| 
    user.posts.create!(title: title, link: link, subreddit_id: subreddit, body: body)
  end
# posts = Post.order(:created_at).take(6)
# posts.each {|post| post.comments.create!(content: body)  }

end