require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('core_auth', '1.0.0') do |config|
  config.summary                  = 'User authentication and role-based authorization.'
  config.author                   = 'Jose Hales-Garcia'
  config.url                      = 'http://github.com/jolohaga/core_auth'
  config.email                    = 'jolohaga@me.com' 
  config.ignore_pattern           = ["tmp/*",".hg/*", ".pkg/*", ".git/*"]
  config.development_dependencies = ['rspec >=1.3.0','echoe >=4.3']
  config.files                    = Dir['lib/**/*']
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each{|ext| load ext}
