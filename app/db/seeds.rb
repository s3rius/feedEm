# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


sellers = %w[CoolFood
             FakeBurgers
             FunnyCrap
             FilthyCream
             ShittyDonuts
             Sim
             BitchyMilk]

sellers.each do |name|
  seller = Seller.create(name: name)
  merchandises = [
    %w[shit fuck 20],
    %w[borgir fish 30],
    %w[burgar beef 30],
    %w[bregar rats 30],
    %w[donut crap 10],
    %w[Fluke shit 10],
    %w[Fuckface you 1],
    %w[cream gold 21],
    %w[semen protein 3],
    %w[bitchWax saliva 15]
  ]
  merchandises.each do |m_name, m_desc, m_price|
    Merchandise.create(name: m_name,
                       description: 'made from ' + m_desc,
                       price: m_price,
                       seller: seller)
  end
end

cu_users = [
  %w[s3rius@shitmail.net 19216211 Pavel Kirilin],
  %w[kolaer@shitmail.net 32883212 Maxim Naumov],
  %w[animeThug@shitmail.net 12332122 Andrei Belousov]
]

cu_users.each do |email, pass, name, surname|
  Customer.create(email: email,
                  name: name,
                  surname: surname,
                  password: pass)
end

