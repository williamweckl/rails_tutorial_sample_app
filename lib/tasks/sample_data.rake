namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Example User",
                 email: "teste@teste.com",
                 password: "Senha123",
                 password_confirmation: "Senha123",
                 admin: true)
    99.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end

    users = User.all.limit(6)
    50.times do |n|
      content = Faker::Lorem.words(5).join(" ")
      users.each { |user| user.microposts.create!(content: content) }
    end

  end
end