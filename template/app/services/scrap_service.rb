class ScrapService
  URL = "https://rubyonrails.org/"

  def scrap!
    begin
      Web.nav(URL) do |driver|
        html = driver.page_source

        page = Nokogiri::HTML(html)

        version = page.at('section.version p a')

        Log.success version.text
      end
    rescue StandardError => e
      Log.error e
    end
  end
end