class Panel < ActiveRecord::Base
  belongs_to :project
  has_many :notes
  
  def before_save
    self.css_name = self.title.gsub(/[^a-zA-Z|\s]/,'').split(' ').join('-').downcase
  end
  
  def after_save
    self.notes.new({:rev => 1 }).save
  end
end
