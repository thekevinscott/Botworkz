class Client < ActiveRecord::Base
  has_many :projects
  belongs_to :user  
  has_many :notes  
end
