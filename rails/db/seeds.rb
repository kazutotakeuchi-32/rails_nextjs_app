# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
# movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
# Character.create(name: "Luke", movie: movies.first)

ActiveRecord::Base.transaction do
  user1 = User.create!(name: 'テスト太郎', email: 'test1@test.com', password: 'password', confirmed_at: Time.current)

  user2 = User.create!(name: 'テスト次郎', email: 'test2@test.com', password: 'password', confirmed_at: Time.current)

  15.times do |i|
    Article.create!(title: "テストタイトル1-#{i}", body: "テスト本文1-#{i}", status: :published, user: user1)
    Article.create!(title: "テストタイトル2-#{i}", body: "テスト本文2-#{i}", status: :published, user: user2)
  end
end

# uid test1@test.com
# access-token IRc_H4-AE2Q2wVlKyfC5kQ
# client 	mCGac2SAu94_h9zmlKik_g
