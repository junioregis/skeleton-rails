class ScrapService
  URL = 'https://www.iplocation.net/find-ip-address'.freeze
  VALUE_REGEX = /(.+)\s*\[/.freeze

  def scrap!
    begin
      Web.nav(URL) do |driver|
        page = Nokogiri::HTML(driver.page_source)

        table = page.css('table.iptable tbody')

        info = table.map do |row|
          cols = row.css('tr td')

          ip = VALUE_REGEX.match(cols[0].text)[1].strip
          location = VALUE_REGEX.match(cols[1].text)[1].strip

          {
              ip: ip,
              location: location,
              host: cols[2].text,
              proxy: cols[3].text.split(',').map(&:strip),
              device: cols[4].text,
              os: cols[5].text,
              browser: cols[6].text,
              agent: cols[7].text,
              javascript: cols[10].text
          }
        end

        Log.success info
      end
    rescue StandardError => e
      Log.error e
    end
  end
end