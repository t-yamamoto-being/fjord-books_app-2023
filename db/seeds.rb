# frozen_string_literal: true

print '開発環境のデータをすべて削除して初期データを投入します。よろしいですか？[Y/n]: ' # rubocop:disable Rails/Output
unless $stdin.gets.chomp.casecmp('Y').zero?
  puts '中止しました。' # rubocop:disable Rails/Output
  return
end

def picture_file(name)
  File.open(Rails.root.join("db/seeds/#{name}"))
end

Book.destroy_all

Book.create!(
  title: 'Ruby超入門',
  memo: 'Rubyの文法の基本をやさしくていねいに解説しています。',
  author: '五十嵐 邦明',
  picture: picture_file('cho-nyumon.jpg')
)

Book.create!(
  title: 'チェリー本',
  memo: 'プログラミング経験者のためのRuby入門書です。',
  author: '伊藤 淳一',
  picture: picture_file('cherry-book.jpg')
)

Book.create!(
  title: '楽々ERDレッスン',
  memo: '実在する帳票から本当に使えるテーブル設計を導く画期的な本！',
  author: '羽生 章洋',
  picture: picture_file('erd.jpg')
)

50.times do
  Book.create!(
    title: Faker::Book.title,
    memo: Faker::Book.genre,
    author: Faker::Book.author,
    picture: picture_file('no-image.png')
  )
end

10.times do |i|
  User.create!(
    email: "user#{i + 1}@example.com",
    password: 'test123456',
    password_confirmation: 'test123456',
    postal_code: "#{rand(100..999)}-#{rand(1000..9999)}",
    address: "#{%w[東京都 大阪府 愛知県 神奈川県 埼玉県 千葉県 兵庫県 福岡県 北海道
                   京都府].sample}#{%w[新宿区 渋谷区 中央区 港区 品川区 目黒区 世田谷区 中野区 杉並区
                                       豊島区].sample}#{['1-1-1', '2-2-2', '3-3-3', '4-4-4', '5-5-5', '6-6-6', '7-7-7', '8-8-8', '9-9-9', '10-10-10'].sample}",
    introduction: "#{%w[読書が趣味です プログラミングを勉強中です 旅行が好きです 料理を楽しんでいます スポーツをしています 音楽を聴くのが好きです 映画鑑賞が趣味です 写真撮影を楽しんでいます ゲームが好きです
                        アートに興味があります].sample}。よろしくお願いします。"
  )
end

Rails.logger.debug '10件のユーザーを作成しました。'
Rails.logger.debug "パスワードは全て 'test123456' です。"
Rails.logger.debug 'メールアドレス: user1@example.com から user10@example.com'

puts '初期データの投入が完了しました。' # rubocop:disable Rails/Output
