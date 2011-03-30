require 'spec_helper'

describe "date_scopes AR specs" do
  before(:each) do
    User.destroy_all
    @users = [
      User.create(:created_at => Date.new(2009, 1, 29)),
      User.create(:created_at => Date.new(2008, 1, 1))  
    ]  
  end
  
  it "have working *_eq" do    
    @by_year = User.created_at_year_eq(2009)
    @by_year.count.should == 1
    @by_year.first.should == @users.first
    
    @by_month = User.created_at_month_eq(1)
    @by_month.count.should == 2
    @by_month.should include(@users.first)
    @by_month.should include(@users.second)    

    @by_month = User.created_at_day_eq(29)
    @by_month.count.should == 1
    @by_month.first.should == @users.first
  end
  
  it "have working *_years/*_months scopes" do
    @years = User.order('created_at DESC').created_at_years.all
    @years.count.should == 2
    @years.first['created_at_year'].should == 2009
    @years.last['created_at_year'].should == 2008

    @months = User.order('created_at DESC').created_at_years.created_at_months.all
    @months.count.should == 2
    @months.first['created_at_month'].should == 1
    @months.last['created_at_month'].should == 1

    @days = User.order('created_at DESC').created_at_days.all
    @days.count.should == 2
    @days.first['created_at_day'].should == 29
    @days.last['created_at_day'].should == 1
  end

  it "have working ascend_*/descend_* scopes" do
    User.ascend_by_created_at.all.should eq(@users.reverse)
    User.descend_by_created_at.all.should eq(@users)
  end
  
  it "gets column value with all_column" do
    User.ascend_by_created_at.created_at_years.all_column.should == [2008, 2009]
  end
end