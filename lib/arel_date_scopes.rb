module ArelDateScopes
  require 'arel_date_scopes/version'    
  require 'arel_date_scopes/arel'
  require 'arel_date_scopes/active_record'
  require 'arel_date_scopes/railtie' if defined?(Rails)
end