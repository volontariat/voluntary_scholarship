# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the home\s?page$/
      '/'
     
    # authentication
    when /^the sign in page$/
      new_user_session_path  
      
    # scholarship program  
    when /the scholarship programs page/
      scholarship_programs_path
    
    when /the new scholarship program page/
      new_scholarship_program_path
    
    when /the scholarship program page/
      scholarship_program_path(@program)
      
    when /the edit scholarship program page/
      edit_scholarship_program_path(@program)
       
    # scholarship team  
    when /the scholarship teams page/
      scholarship_teams_path
    
    when /the new scholarship team page/
      new_scholarship_team_path
    
    when /the scholarship team page/
      scholarship_team_path(@team)
      
    when /the edit scholarship team page/
      edit_scholarship_team_path(@team)       
       
   # scholarship iteration  
    when /the scholarship iterations page/
      scholarship_program_iterations_path(@program)
    
    when /the new scholarship iteration page/
      new_scholarship_program_iteration_path(@program)
    
    when /the scholarship iteration page/
      scholarship_iteration_path(@iteration)
      
    when /the edit scholarship iteration page/
      edit_scholarship_iteration_path(@iteration)    
       
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
  
  def login_page
    path_to "the new user session page"
  end
end

World(NavigationHelpers)
