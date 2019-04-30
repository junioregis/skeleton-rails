namespace :system do
  task update: :environment do
    service = Proxy.new
    service.update!
  end
end
