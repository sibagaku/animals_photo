# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
    email: "admin@admin",
    password: "admintest"
  )
  
 users = User.create!(
    [
      {email: "userA@test.com", password: "password", name: "テストユーザー1", self_introduction: "テストユーザー1人目", profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/test-user1.jpg"), filename: "test-user1.jpg")},
      {email: "userB@test.com", password: "password", name: "テストユーザー2", self_introduction: "テストユーザー2人目", profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/test-user2.jpg"), filename: "test-user2.jpg")},
      {email: "userC@test.com", password: "password", name: "テストユーザー3", self_introduction: "テストユーザー3人目", profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/test-user3.jpg"), filename: "test-user3.jpg")},
    ] 
  )
  
Post.create!(
    [
      {introduction: "街中で見つけた茶色い鳩", user_id: users[0].id, image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/test-post1.jpg"), filename: "test-post1.jpg")},
      {introduction: "ぐっすり眠っているトラ", user_id: users[1].id, image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/test-post2.jpg"), filename: "test-post2.jpg")},
      {introduction: "群れをなすヤギ", user_id: users[2].id, image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/test-post3.jpg"), filename: "test-post3.jpg")},
    ]
  )