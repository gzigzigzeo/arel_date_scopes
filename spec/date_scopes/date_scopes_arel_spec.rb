require 'spec_helper'

describe "date_scopes AREL extensions" do
  before(:each) do
    Arel::Table.engine = Arel::Sql::Engine.new(FakeRecord::Base.new)
    @table = Arel::Table.new(:users)
    @visitor = Arel::Visitors::MySQL.new Arel::Table.engine    
  end
  
  it "should correctly transform to_sql DATE, MONTH, DAYOFMONTH" do
    puts @visitor.accept(@table[:created_at].year.eq(2009))
    puts @visitor.accept(@table[:created_at].month.in(1..12))
    puts @visitor.accept(@table[:created_at].dayofmonth.gt(10))    
    puts @table.project(@table[:created_at].year).group(@table[:created_at].year).to_sql
  end
end