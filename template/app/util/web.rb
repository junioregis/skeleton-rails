require 'phantomjs'
require 'selenium-webdriver'

module Web
  def self.nav(url)
    driver = case (Rails.env)
             when 'test'
               options = Selenium::WebDriver::Chrome::Options.new

               chrome_bin_path = ENV.fetch('GOOGLE_CHROME_SHIM', nil)

               options.binary = chrome_bin_path if chrome_bin_path
               options.add_argument('--headless')

               Selenium::WebDriver.for :chrome, options: options
             else
               Selenium::WebDriver.for(:remote,
                                       url: 'http://selenium:4444/wd/hub',
                                       desired_capabilities: :chrome)
             end


    driver.manage.timeouts.implicit_wait = 10 # seconds
    driver.navigate.to url

    yield driver

    driver.quit
  end
end