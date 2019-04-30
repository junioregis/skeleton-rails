require 'phantomjs'
require 'selenium-webdriver'

module Web
  def self.nav(url, options = {})
    default_options = {
        proxy: true
    }

    options.reverse_merge! default_options

    Log.debug "URL: #{url}"

    capabilities = if options[:proxy]
                     proxies = System::Redis.get(:proxies)

                     unless proxies
                       Log.error "Please, run 'system:update' task"
                       return
                     end

                     proxy_config = proxies.first(10).sample

                     proxy = Selenium::WebDriver::Proxy.new http: "#{proxy_config[:ip]}:#{proxy_config[:port]}"

                     Log.debug "PROXY: #{proxy_config[:ip]}:#{proxy_config[:port]} (#{proxy_config[:speed]})"

                     Selenium::WebDriver::Remote::Capabilities.chrome proxy: proxy, ssl: proxy
                   else
                     Selenium::WebDriver::Remote::Capabilities.chrome
                   end

    driver = case (Rails.env)
             when 'test'
               options = Selenium::WebDriver::Chrome::Options.new

               chrome_bin_path = ENV.fetch('GOOGLE_CHROME_SHIM', nil)

               options.binary = chrome_bin_path if chrome_bin_path
               options.add_argument('--headless')

               Selenium::WebDriver.for desired_capabilities: capabilities,
                                       options: options
             else
               Selenium::WebDriver.for(:remote,
                                       url: 'http://selenium:4444/wd/hub',
                                       desired_capabilities: capabilities)
             end

    begin
      driver.navigate.to url

      yield driver
    rescue Net::ReadTimeout => e
      Log.error e
      Web.nav(url, options) do
        yield driver
      end
    rescue StandardError => e
      Log.error e
    ensure
      driver.quit
    end
  end
end