Gem::Specification.new do |gem|
  gem.name    = 'core_auth'
  gem.version = '0.1.0'
  gem.authors = 'Jose Hales-Garcia'
  gem.email = 'jolohaga@me.com'
  gem.homepage = %q{http://github.com/jolohaga/core_auth}
  gem.date = '2010-04-07'
  gem.description = 'User authentication and role-based authorization.'
  gem.summary = 'User authentication and role-based authorization.'
  gem.rubyforge_project = %q{core_auth}
  gem.files = Dir['lib/**/*']
  gem.add_dependency 'rails', '3.0.0.beta2'
end