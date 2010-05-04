class Client < ActiveRecord::Base
  has_many :projects
  belongs_to :user  
  has_many :notes
  
  def before_create
    if self.url.nil?
      self.url = self.name.gsub(/[^a-zA-Z|\s]/,'').split(' ').join('-').downcase
    end
  end
end
