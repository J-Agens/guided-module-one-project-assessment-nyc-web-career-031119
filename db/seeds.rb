require 'rest-client'
require 'json'
require 'pry'

response = RestClient.get('https://jobs.github.com/positions.json?utf8=%E2%9C%93&description=developer&location=new+york')
data = JSON.parse(response.body)

i = 0
data.each do |job_hash|
  Job.create(title: data[i]["title"], location: data[i]["location"], description: data[i]["description"], company: data[i]["company"], job_type: data[i]["type"], github_id: data[i]["id"])
  i += 1
end

3.times do
  User.create(name: Faker::Name.name, location: Faker::Address.state, favorite_language: "ruby")
end

3.times do
  User.create(name: Faker::Name.name, location: Faker::Address.state, favorite_language: "javascript")
end

3.times do
  User.create(name: Faker::Name.name, location: Faker::Address.state, favorite_language: "java")
end

3.times do
  User.create(name: Faker::Name.name, location: Faker::Address.state, favorite_language: "php")
end

60.times do
  Application.create(user_id: rand(User.first.id..(User.all.length + User.all.first.id)), job_id: rand(Job.first.id..(Job.all.length + Job.all.first.id)))
end

# binding.pry
#
#
# puts "the ends"
