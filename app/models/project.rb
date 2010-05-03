class Project < ActiveRecord::Base
  belongs_to :client
  belongs_to :user
  has_many :notes
  
  def initialise(params = nil)  
    super  
    self.archive = false unless self.archive
  end
end
