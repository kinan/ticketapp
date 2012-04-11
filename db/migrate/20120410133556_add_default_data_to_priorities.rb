class AddDefaultDataToPriorities < ActiveRecord::Migration
  def change
  	Priority.create :name => 'Critical', :days => 1
  	Priority.create :name => 'High', :days => 7
  	Priority.create :name => 'Medium', :days => 10
  	Priority.create :name => 'Low', :days => 20
  end
end
