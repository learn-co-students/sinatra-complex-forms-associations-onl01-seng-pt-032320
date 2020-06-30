# Add seed data here. Seed your database with `rake db:seed`
sophie = Owner.create(name: "Sophie")
Pet.create(name: "Maddy", owner_id: sophie)
Pet.create(name: "Nona", owner_id: sophie)