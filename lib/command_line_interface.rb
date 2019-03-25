def welcome
  puts "Welcome unemployed person!"
  puts "What is your name?"
end

def get_name
  user_input = gets.chomp
  User.create(name: user_input)
end

def get_location
  puts "Where would you like to work?"
  user_input = gets.chomp

  response = RestClient.get("https://jobs.github.com/positions.json?utf8=%E2%9C%93&description=&location=#{user_input.split(' ').join('+')}")
  data = JSON.parse(response.body)

  i = 0
  data.each do |job_hash|
    puts "****************"
    puts data[i]["title"]
    puts data[i]["company"]
    puts data[i]["type"]
    puts data[i]["location"]
    i += 1
  end

end

# def add_user
#   User.create(name: get_name)
# end
