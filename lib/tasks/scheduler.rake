require "#{Rails.root}/app/helpers/posts_helper"
include PostsHelper

desc "This task is called by the Heroku scheduler add-on"
task :update_scores => :environment do
  puts "Updating post scores..."
  update_sort_scores
  puts "done."
end

# task :send_reminders => :environment do
#   User.send_reminders
# end
