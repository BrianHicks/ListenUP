require 'machinist/active_record'
require 'faker'

# Add your blueprints here.
#
# e.g.
#   Post.blueprint do
#     title { "Post #{sn}" }
#     body  { "Lorem ipsum..." }
#   end

User.blueprint do
  email { Faker::Internet.email }
  password { "password" }
  password_confirmation { "password" }
  is_admin { false }
end

User.blueprint(:admin) do
  is_admin { true }
end

Survey.blueprint do
  name { Faker::Lorem.words(2) }
  intro { Faker::Lorem.words(40) }
  thank_you { Faker::Lorem.words(40) }
end

Question.blueprint do
  content { Faker::Lorem.words(8) }
  kind { "text" }
end

Recipient.blueprint do
  email { Faker::Internet.email }
end

Recipient.blueprint(:no_email) do
  no_email { true }
end

Answer.blueprint do
  content { Faker::Lorem.words(3) }
end
