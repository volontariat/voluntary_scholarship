$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "voluntary_scholarship/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "voluntary_scholarship"
  s.version     = VoluntaryScholarship::VERSION
  s.authors     = ["Mathias Gawlista"]
  s.email       = ["gawlista@gmail.com"]
  s.homepage    = "http://github.com/volontariat/voluntary_scholarship"
  s.summary     = "Scholarship product for crowdsourcing engine voluntary."
  s.description = "Scholarship product for crowdsourcing engine voluntary."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency 'voluntary'

  s.add_development_dependency "pg"
end
