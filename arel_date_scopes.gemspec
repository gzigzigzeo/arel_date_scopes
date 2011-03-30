# encoding: utf-8

$:.push File.expand_path("../lib", __FILE__)
require "arel_date_scopes/version"

Gem::Specification.new do |s|
  s.name = %q{arel_date_scopes}
  s.version = ArelDateScopes::VERSION

  s.authors = ["Victor Sokolov"]
  s.description = %q{SQL date functions for AREL 2 + AR 3 scopes (such as created_at_year_eq)}
  s.email = %q{gzigzigzeo@gmail.com}
  s.homepage = %q{http://github.com/gzigzigzeo/arel_date_scopes}
  s.rdoc_options = ["--charset=UTF-8"]
  s.summary = %q{SQL date functions for AREL 2 + AR 3 date scopes (such as created_at_year_eq)}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency(%q<arel>, [">= 2"])
  s.add_dependency(%q<active_record>, [">= 3"])  
  
  s.add_development_dependency('sqlite3-ruby')
end