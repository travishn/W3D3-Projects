# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

alex = User.create(email: "alex@alex.com")
travis = User.create(email: "travis@travis.com")
aA = User.create(email: "appacademy@aA.com")

ShortenedUrl.create_shortened_url(alex, "youtube.com")
ShortenedUrl.create_shortened_url(travis, "vimeo.com")
ShortenedUrl.create_shortened_url(aA, "yahoo.com")


