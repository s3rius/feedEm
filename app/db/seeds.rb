# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


sellers = %w[CoolFood FakeBurgers FunnyCrap FilthyCream ShittyDonuts Sim BitchyMilk]

sellers.each do |name|
  seller = Seller.create(name: name)
  merchandises = [
      %w[shit fuck 20],
      %w[borgir meat 30],
      %w[donut, crap, 10],
      %w[Fluke, crap, 10],
      %w[Fuckface, you, 1],
      %w[cream, knif, 21]
  ]
  merchandises.each do |m_name, m_desc, m_price|
    Merchandise.create(name: m_name, description: m_desc, price: m_price, seller: seller)
  end
end

cu_users = [
    %w[s3rius 19216211 Pavel Kirilin],
    %w[kolaer 32883212 Maxim Naumov]
]

cu_users.each do |username, pass, name, surname|
  Customer.create(username: username,
                  name: name,
                  surname: surname,
                  password_digest: pass)
end

