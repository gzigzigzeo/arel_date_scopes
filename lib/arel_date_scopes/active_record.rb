module ArelDateScopes
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
        
        scope :"#{field}_years", lambda {
          t = arel_table
          select(t[field].year.as("#{field}_year")).group(t[field].year)
        }

        scope :"#{field}_months", lambda {
          t = arel_table
          select(t[field].month.as("#{field}_month")).group(t[field].month)
        }

        scope :"#{field}_days", lambda {
          t = arel_table
          select(t[field].dayofmonth.as("#{field}_day")).group(t[field].dayofmonth)
        }
        
        scope :"descend_by_#{field}", order("#{field} DESC")
        scope :"ascend_by_#{field}", order("#{field} ASC")        
      end
      
      def all_column(field = nil)
        rows = scoped.all
        return [] if rows.empty?
        field ||= rows.first.attributes.keys.first
        rows.map { |row| row[field] }
      end
    end
  end
end