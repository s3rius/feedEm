# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


sellers = %w[CoolFood
             FakeBurgers
             FunnyMall]

sellers.each do |name|
  seller = Seller.create(name: name)
  merchandises = [
    %w[Burger Burger 20],
    %w[CheeseBurger CheeseBurger 25],
    %w[Chocolate Chocolate 15],
    %w[Cola Soda 10],
    %w[Sprite Soda 10],
  ]
  merchandises.each do |m_name, m_desc, m_price|
    Merchandise.create(name: m_name,
                       description: 'made from ' + m_desc,
                       price: m_price,
                       cook_time: 20,
                       seller: seller)
  end
end

cu_users = [
  %w[s3rius@emial.mail 19216211 Pavel Kirilin],
  %w[kolaer@emial.mail 32883212 Maxim Naumov],
  %w[animeThug@emial.mail 12332122 Andrei Belousov]
]

cu_users.each do |email, pass, name, surname|
  Customer.create(email: email,
                  name: name,
                  surname: surname,
                  password: pass)
  Admin.create(email: email, password: pass)
end

