source "http://rubygems.org"
ruby "1.9.3"

# utility
gem "rake"
gem "colorize"
gem "builder"

## middleman
gem "middleman"
gem "middleman-blog"

## rendering engines
gem "haml"
gem "sass"
gem "redcarpet"

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

group :deployment do
	gem "net-ssh-simple"
end

group :testing do
  gem "rspec"
  # gem "autotest"
end