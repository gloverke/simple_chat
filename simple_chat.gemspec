$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "simple_chat/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "simple_chat"
  s.version     = SimpleChat::VERSION
  s.authors     = ["Kris Glover"]
  s.email       = ["me@krisglover.com"]
  s.homepage    = "http://www.krisglover.com"
  s.summary     = "Chat Skills Demo"
  s.description = "A Simple Cht room to demonstrate Rails/Javscript/HTML5/CSS3  technologies/skills"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.1.5"

  s.add_dependency "mysql2"
  s.add_development_dependency "rspec"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "capybara"
  s.add_development_dependency "guard"
  s.add_development_dependency "guard-rspec"

end
