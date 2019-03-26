require 'rest-client'
require 'json'
require 'pry'

response = RestClient.get('https://jobs.github.com/positions.json?utf8=%E2%9C%93&description=developer&location=new+york')
data = JSON.parse(response.body)

binding.pry

i = 0
data.each do |job_hash|
  Job.create(title: data[i]["title"], location: data[i]["location"], description: data[i]["description"], company: data[i]["company"], job_type: data[i]["type"], github_id: data[i]["id"])
  i += 1
end





# binding.pry
#
#
# puts "the ends"
