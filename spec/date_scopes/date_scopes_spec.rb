require 'spec_helper'

describe "date_scopes AR specs" do  
  it "should correctly transform to_sql DATE, MONTH, DAYOFMONTH" do
    User.created_at_year_eq(2009).to_sql.should eq('SELECT "users".* FROM "users" WHERE (YEAR("users"."created_at") = 2009)')
  end
end