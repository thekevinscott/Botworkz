class Note < ActiveRecord::Base
  belongs_to :client
  belongs_to :project
  belongs_to :user    
end
