require 'spec_helper'

describe "date scopes AR specs" do  
  it "_eq scopes should exists" do
    User.created_at_year_eq(2009).to_sql.should eq('SELECT "users".* FROM "users" WHERE YEAR("users"."created_at") = 2009')
    User.created_at_month_eq(1).to_sql.should eq('SELECT "users".* FROM "users" WHERE MONTH("users"."created_at") = 1')
    User.created_at_day_eq(29).to_sql.should eq('SELECT "users".* FROM "users" WHERE DAYOFMONTH("users"."created_at") = 29')
  end
  
  it "_years/_months scopes should exits" do
    User.created_at_years.to_sql.should eq('SELECT YEAR("users"."created_at") AS \'created_at_year\' FROM "users" GROUP BY YEAR("users"."created_at")')
    User.created_at_months.to_sql.should eq('SELECT MONTH("users"."created_at") AS \'created_at_month\' FROM "users" GROUP BY MONTH("users"."created_at")')    
    User.created_at_days.to_sql.should eq('SELECT DAYOFMONTH("users"."created_at") AS \'created_at_day\' FROM "users" GROUP BY DAYOFMONTH("users"."created_at")')        
  end

  it "ascend_/descend_ scopes should exits" do
    User.created_at_year_eq(2009).ascend_by_created_at.to_sql.should eq('SELECT "users".* FROM "users" WHERE YEAR("users"."created_at") = 2009 ORDER BY created_at ASC')
    User.created_at_year_eq(2009).created_at_month_eq(1).descend_by_created_at.to_sql.should eq('SELECT "users".* FROM "users" WHERE YEAR("users"."created_at") = 2009 AND MONTH("users"."created_at") = 1 ORDER BY created_at DESC')    
  end
end