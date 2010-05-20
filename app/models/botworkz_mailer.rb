class BotworkzMailer < ActionMailer::Base
  def summarize_projects
      recipients "thekevinscott@gmail.com"
      from       "Botworkz"
      subject    "Your daily summary of your projects"
      sent_on    Time.now
      body       
    end
  

end
