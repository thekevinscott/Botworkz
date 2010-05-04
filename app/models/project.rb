class Project < ActiveRecord::Base
  belongs_to :client
  belongs_to :user
  has_many :notes

  
  def initialise(params = nil)  
    super  
    self.archive = false unless self.archive
  end
  
  
  def before_save
    if self.url.nil? || self.url.empty?
      self.url = self.title.gsub(/[^a-zA-Z|\s]/,'').split(' ').join('-').downcase
      
      self.check_url_availability
      
    end
  end
  
  def check_url_availability
    #@count = Project.find(:all,:conditions=>"url = '"+self.url+"' ").count
    if ! Project.find_by_url(self.url).nil?
      # then it already exists. are there other numbered projects like this?
      @items = Project.find(:all,:conditions=>"url LIKE 'rock-it%' ")
      if @items.count > 2 # 2, because we're looking for 1 BUT we just created this guy, which makes it 2        
        self.url = self.url + '-' + (@items.last.url.split('-').pop.to_i+1).to_s
      else
        self.url = self.url + '-2'
      end
    end
  end
  
end
