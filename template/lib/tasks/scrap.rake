task scrap: :environment do
  service = ScrapService.new
  service.scrap!
end
