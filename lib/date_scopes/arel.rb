module Arel
  module Nodes
    class Year < Arel::Nodes::Function
      include Arel::Predications
    end

    class Month < Arel::Nodes::Function
      include Arel::Predications      
    end

    class DayOfMonth < Arel::Nodes::Function
      include Arel::Predications      
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