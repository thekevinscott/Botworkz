task :cron => :environment do
  BotworkzMailer.deliver_summarize_projects

end
