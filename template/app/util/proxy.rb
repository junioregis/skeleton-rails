class Proxy
  URL = 'https://hidemyna.me/en/proxy-list'.freeze
  OPTIONS = {
      maxtime: 300,
      type: 's5',
      anon: 4
  }.freeze

  def initialize
    params = OPTIONS.map do |k, v|
      "#{k}=#{v}"
    end.join('&')

    @url = "#{URL}/?#{params}"
  end

  def update!
    System::Redis.set :proxies, proxies

    Log.success "UP-TO-DATE"
  end

  private

  def html
    begin
      Web.nav(@url, proxy: false) do |driver|
        wait = Selenium::WebDriver::Wait.new
        wait.until {
          driver.find_element(:css, 'table[class=proxy__t]').displayed?

          return Nokogiri::HTML(driver.page_source)
        }
      end
    rescue StandardError => e
      Log.error e
    end
  end

  def proxies
    items = html.css('table tbody tr')
    items.map do |row|
      cols = row.css('td')

      {
          ip: cols[0].text,
          port: cols[1].text,
          speed: cols[3].text
      }
    end.sort_by {|k, _| k[:speed]}
  end
end