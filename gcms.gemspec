$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "gcms"
  s.version     = '0.0.1'
  s.authors     = ["ktp"]
  s.email       = ["ktp@example.com"]
  s.homepage    = "http://com.ru"
  s.summary     = "GCMS"
  s.description = "KGCMS"

  s.files = Dir["{app,config,db,lib,vendor}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 4.2.0"
  s.add_dependency "bower-rails", "~> 0.9.1"
  s.add_dependency "slim-rails"
  s.add_dependency "less-rails"
  s.add_dependency 'russian'
  s.add_dependency 'therubyracer'
  s.add_dependency 'angular-rails-templates', '~> 1.0.0'
  s.add_dependency 'liquor'#, github: 'webgradus/liquor'
  s.add_dependency 'carrierwave'
  s.add_dependency 'active_model_serializers'
  s.add_dependency 'ancestry'
  s.add_dependency 'devise'
  s.add_dependency 'evil-front'
  s.add_dependency 'cancancan', '~> 1.9'
  s.add_dependency 'dragonfly', '~> 1.0.7'
  s.add_dependency 'pg'
  s.add_dependency 'textacular', '~> 3.0'

  s.add_development_dependency 'combustion', '~> 0.5.4'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'airborne'
  s.add_development_dependency 'byebug'
end
