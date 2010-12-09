module DateScopes
  # Workaround for Rails. Rails tries to threat left operands of == as Attribute object, but it can be
  # a function like YEAR(). Fake #name should return "#{field}_#{function}" to resolve field conflicts.
  module ArelAttributeEmulation
    def name; self.expressions.first.name.to_s + '_' + self.class.name.underscore; end      
    def relation; self.expressions.first; end          
  end
end

module Arel
  module Nodes
    class Year < Arel::Nodes::Function
      include Arel::Predications
      include DateScopes::ArelAttributeEmulation
    end

    class Month < Arel::Nodes::Function
      include Arel::Predications
      include DateScopes::ArelAttributeEmulation      
    end

    class DayOfMonth < Arel::Nodes::Function
      include Arel::Predications
      include DateScopes::ArelAttributeEmulation      
    end
  end

  module Attributes
    class Time
      def year
        Nodes::Year.new [self]
      end

      def month
        Nodes::Month.new [self]
      end

      def dayofmonth
        Nodes::DayOfMonth.new [self]
      end
    end    
  end

  module Visitors
    class MySQL
      private
      def visit_Arel_Nodes_Year o
        "YEAR(#{o.expressions.map { |x|
          visit x }.join(', ')})#{o.alias ? " AS #{visit o.alias}" : ''}"
      end      

      def visit_Arel_Nodes_Month o
        "MONTH(#{o.expressions.map { |x|
          visit x }.join(', ')})#{o.alias ? " AS #{visit o.alias}" : ''}"
      end
  
      def visit_Arel_Nodes_DayOfMonth o
        "DAYOFMONTH(#{o.expressions.map { |x|
          visit x }.join(', ')})#{o.alias ? " AS #{visit o.alias}" : ''}"
      end        
    end
  end
end