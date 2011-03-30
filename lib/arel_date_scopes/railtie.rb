module ArelDateScopes
  class Railtie < Rails::Railtie
    initializer 'arel_date_scopes.insert_into_active_record' do
      ActiveSupport.on_load :active_record do
        ::ActiveRecord::Base.send(:include, ArelDateScopes::ActiveRecord)
      end
    end
  end
end