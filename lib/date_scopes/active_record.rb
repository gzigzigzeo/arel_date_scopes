module DateScopes
  module ActiveRecord
    extend ActiveSupport::Concern

    module ClassMethods
      def date_scopes_for(field)
        scope :"#{field}_year_eq", lambda { |year|
          t = arel_table
          where(t[field].year.eq(year))
        }
        
        scope :"#{field}_month_eq", lambda { |month|
          t = arel_table
          where(t[field].month.eq(month))
        }

        scope :"#{field}_day_eq", lambda { |day|
          t = arel_table
          where(t[field].dayofmonth.eq(day))
        }
      end
    end
  end
end