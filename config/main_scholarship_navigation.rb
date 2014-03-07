SimpleNavigation::Configuration.run do |navigation|
  instance_exec navigation, &VoluntaryScholarship::Navigation.code
end