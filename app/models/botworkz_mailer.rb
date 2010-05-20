class BotworkzMailer < ActionMailer::Base
  def summarize_projects
      @from = "botworkz@gmail.com"
      @recipients = "thekevinscott@gmail.com"
      @subject = "Your daily summary of projects"
      @body = {:projects => Project.all}
      
    end
  

end
