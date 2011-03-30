require 'spec_helper'

describe "date_scopes AREL extensions" do
  before(:each) { @table = Arel::Table.new(:users) }
  
  context("for MySQL") do
    before(:each) do
      @visitor = Arel::Visitors::MySQL.new(Arel::Sql::Engine.new(FakeRecord::Base.new('mysql')))
    end
  
    it "should correctly transform to_sql DATE, MONTH, DAYOFMONTH" do
      @visitor.accept(@table[:created_at].year.eq(2009)).should eq('YEAR("users"."created_at") = 2009')
      @visitor.accept(@table[:created_at].month.in(1..12)).should eq('MONTH("users"."created_at") BETWEEN 1 AND 12')  
      @visitor.accept(@table[:created_at].dayofmonth.gt(10)).should eq('DAYOFMONTH("users"."created_at") > 10')        
      @table.project(@table[:created_at].year).group(@table[:created_at].year).to_sql.should 
        eq('SELECT YEAR("users"."created_at") FROM "users" GROUP BY YEAR("users"."created_at")')
    end
  end

  context("for SQLite") do
    before(:each) do      
      @visitor = Arel::Visitors::SQLite.new(Arel::Sql::Engine.new(FakeRecord::Base.new('sqlite')))
    end
  
    it "should correctly transform to_sql DATE, MONTH, DAYOFMONTH" do
      @visitor.accept(@table[:created_at].year.eq(2009)).should eq('CAST(STRFTIME(\'%Y\', "users"."created_at") AS INTEGER) = 2009')
      @visitor.accept(@table[:created_at].month.in(1..12)).should eq('CAST(STRFTIME(\'%m\', "users"."created_at") AS INTEGER) BETWEEN 1 AND 12')  
      @visitor.accept(@table[:created_at].dayofmonth.gt(10)).should eq('CAST(STRFTIME(\'%d\', "users"."created_at") AS INTEGER) > 10')        
      @table.project(@table[:created_at].year).group(@table[:created_at].year).to_sql.should 
        eq('SELECT CAST(STRFTIME(\'%Y\', "users"."created_at") AS INTEGER) FROM "users" GROUP BY CAST(STRFTIME(\'%Y\', "users"."created_at") AS INTEGER)')
    end
  end
end