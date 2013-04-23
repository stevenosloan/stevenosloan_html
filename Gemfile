source "http://rubygems.org"
ruby "1.9.3"

# utility
gem "rake"
gem "colorize"
gem "builder"
gem 'statistrano', :git => 'git@github.com:mailchimp/statistrano.git'

## middleman
gem "middleman"
gem "middleman-blog"
gem "middleman-syntax"

## rendering engines
gem "haml"
gem "sass"
gem "redcarpet"
gem "nokogiri"

## runtime env
gem "therubyracer"

group :development do

  gem "middleman-livereload"

  gem "thin"
  gem "foreman"

  gem "rack"
	gem "rack-rewrite"
  gem "rack-legacy"

end

group :testing do
  gem "rspec"
  gem "autotest"
end