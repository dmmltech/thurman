# to use, run: rake article:publish_due or heroku run rake article:publish_due


namespace :article do
  task :publish_due => [:environment] do
    Article.publish_scheduled
  end
end
