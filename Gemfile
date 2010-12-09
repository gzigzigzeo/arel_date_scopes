source "http://rubygems.org"

gem 'arel', '>= 2'
gem 'arel_date_scopes', :path => '.'

if RUBY_VERSION < '1.9'
  gem "ruby-debug", ">= 0.10.3"
end

group :test do
  gem "activerecord", "> 3", :require => "active_record"
  gem "activesupport", "> 3"  
  gem "sqlite3-ruby"
end

gem "rspec"