class Priority < ActiveRecord::Base
  attr_accessible :days, :name

  has_many :tickets

  validates :name, :days, :presence => true
  validates :days, :numericality => { :only_integer => true, :greater_than => 0  }

  default_scope order("days")
end
