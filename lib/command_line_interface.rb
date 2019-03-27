class CommandLineInterface

  attr_accessor :user, :searched_jobs

  def initialize
    @searched_jobs = []
    @apps_sent = 0
  end

  def welcome
    puts "Welcome unemployed person!"
    print "What is your name? "
  end

  def get_name
    user_input = gets.chomp
    if User.find_by(name: user_input) == nil
      self.user = User.create(name: user_input)
    else
      self.user = User.find_by(name: user_input)
      puts "Welcome Back #{user_input}"
    end
  end

  def get_location
    print "Where would you like to work? "
    user_input = gets.chomp
    @user.location = user_input
    @user.save
  end

  def display_search
    response = RestClient.get("https://jobs.github.com/positions.json?utf8=%E2%9C%93&description=#{@user.favorite_language.split(' ').join('+')}&location=#{@user.location.split(' ').join('+')}")
    data = JSON.parse(response.body)

    i = 0
    data.each do |job_hash|
      puts "****************"
      puts data[i]["title"]
      puts data[i]["company"]
      puts data[i]["type"]
      puts data[i]["location"]
      puts "ID ##{data[i]["id"].slice(-5, 5)}"
      @searched_jobs << Job.new(title: data[i]["title"], location: data[i]["location"], description: data[i]["description"], company: data[i]["company"], job_type: data[i]["type"], github_id: data[i]["id"])
      i += 1
    end
    print "Would you like to apply to any of these jobs?" + " (Y/N): ".green
  end

  def get_language
    print "What programming language do you prefer? "
    user_input = gets.chomp
    @user.favorite_language = user_input
    @user.save
  end

def apply_to_job
  # print "Would you like to apply to any of these jobs? (Y/N):"
  user_input = gets.chomp
  if user_input.downcase == "y" || user_input.downcase == "yes"
    puts "Which job would you like to apply for?"
    print "Type in the job ID# :"
    user_input = gets.chomp
    new_job = @searched_jobs.find do |job|
      job.github_id.include?(user_input)
    end
    if !gh_ids_of_jobs_applied.include?(user_input)
      new_job.save
      Application.create(user_id: @user.id, job_id: new_job.id)
      puts "APPLICATION SAVED".colorize(:green)
    else
      puts "YOU'VE ALREADY APPLIED TO THIS JOB".red
      print "Do you want send another application? (Y/N): "
      user_input = gets.chomp
      if user_input.downcase == "y" || user_input.downcase == "yes"
        new_job.save
        Application.create(user_id: @user.id, job_id: new_job.id)
        puts "APPLICATION SAVED".colorize(:green)
      else
        puts "Good choice!"
      end
    end
    print "Would you like to apply to another one of these jobs?" + "(Y/N): ".green
    new_input = gets.chomp
    if new_input.downcase == "y" || user_input.downcase == "yes"
      apply_again
    else
      puts "..."
    end
  elsif user_input.downcase == "n" || user_input.downcase == "no"
    puts "..."
  end
end

def apply_again
  display_search
  apply_to_job
end

  def display_user_applications
    puts "You have #{list_of_applications.count} applications saved."
    list_of_applications.each do |application|
      puts "*" * 7
      puts Job.where(id: application.job_id)[0].title
      puts Job.where(id: application.job_id)[0].location
      puts "ID#:#{Job.where(id: application.job_id)[0].id}"
      puts "-" * 7
    end
  end

  def list_of_applications
    Application.where(user_id: @user.id)
  end

  def gh_ids_of_jobs_applied
    list_of_applications.map do |app|
      app.job.github_id.slice(-5, 5)
    end
  end

  def applications_menu
    menu_input = ""
    while menu_input != "3"
      puts "Here are your options"
      puts "    1) Read description of a job. 2)Remove an application".colorize(:blue)
      puts "    3) Return to main menu.".colorize(:blue)
      print "Type in the number of your choice: "
      menu_input = gets.chomp
      if menu_input == "1"
        print "Type in the ID number of the job you would like to see more information on: "

        menu_input = gets.chomp
        if Job.where(id: menu_input)[0] != nil
        puts Job.where(id: menu_input)[0].description
        puts "-" * 7
        else
          puts "Invalid input, please try again.".colorize(:red)
        end

      elsif menu_input == "2"
        print "Type in the ID of the application you would like to remove: "
        menu_input = gets.chomp
        Application.where(job_id: menu_input)[0].destroy
        puts "REMOVAL SUCCESSFUL!".green

      elsif menu_input == "3" || list_of_applications.count == 0
        puts `clear`
        puts "Returned to Main Menu".colorize(:red)
      else
        puts "Invalid input, please try again.".colorize(:red)
      end
    end
  end

  # SEE popular jobs option 3

  def sort_popular_jobs
    Application.group(:job).count.sort_by do |job|
      job[1]
    end.reverse
  end

  def display_popular_jobs
    puts "These are the hottest jobs on the market"
    sort_popular_jobs.first(5).each do |job|
      puts "#{job[0].title.upcase}".colorize(:green) + " with " + "#{job[1]}".colorize(:red) + " applications."
      puts "*" *7
    end
  end

  def sort_all_users_by_app_count
    Application.group(:user).count.sort_by do |application|
      application[1]
    end.reverse
  end

  def display_leaderboard
    puts "    TOP FIVE USERS".colorize(:red)
    sort_all_users_by_app_count.first(5).each do |user|
      puts "#{user[0].name} : #{user[1]}"
    end
  end

  def exit_job_search
    puts "GOODBYE".colorize(:red)
  end

  ### Main Menu ###
  def run
    welcome
    input = ""
    get_name
    while input != "5"
      puts "    1) Search for a new job.  2) See my applications.".colorize(:blue)
      puts "    3) See popular jobs.      4) See Users with Most Applications".colorize(:blue)
      puts "    5) Exit".colorize(:blue)
      print "What would you like to do today? "
      input = gets.chomp
      if input == "1"
        get_location
        get_language
        puts `clear`
        display_search
        apply_to_job
      elsif input == "2"
        if list_of_applications.count > 0
          display_user_applications
          applications_menu
        else
          puts "You have 0 applications saved".colorize(:red)
          puts "Returned to Main Menu".colorize(:red)
        end
      elsif input == "3"
      sort_popular_jobs
      display_popular_jobs
      elsif input == "4"
        display_leaderboard
      elsif input == "5"
        puts `clear`
        exit_job_search
      end
    end
  end

end
