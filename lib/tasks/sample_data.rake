namespace :db do
  desc "Fill Database With Sample Data"
  task populate: :environment do
    User.create!(name: "Admin",
    		 email: "example@railstutorial.org",
		 password: "foobah",
		 password_confirmation: "foobah",
		 username: "adminuser",
		 admin: true)
    99.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password = "password"
      uname = "exuname#{n+1}"
      User.create!(name: name,
      		   email: email,
		   password: password,
		   password_confirmation: password,
		   username: uname)
    end
    users = User.all(limit: 6)
    50.times do
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.microposts.create!(content: content) }
    end

    users = User.all
    user = users.first
    followed_users = users[2..50]
    followers = users[3..40]
    followed_users.each { |followed| user.follow!(followed) }
    followers.each { |follower| follower.follow!(user) }
  end
end
