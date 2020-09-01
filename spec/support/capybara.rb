# Capybara.register_driver :chrome_headless do |app|
#   options = ::Selenium::WebDriver::Chrome::Options.new

#   options.add_argument('--headless')
#   options.add_argument('--no-sandbox')
#   options.add_argument('--disable-dev-shm-usage')
#   options.add_argument('--window-size=1400,1400')

#   Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
# end

Capybara.register_driver :selenium_container do |app|
  url = ENV["SELENIUM_DRIVER_URL"]
  caps = ::Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: { args: [
      'headless',
      'no-sandbox',
      'disable-gpu',
      'window-size=1400,1400'
    ],
    w3c: false}
  )
  Capybara::Selenium::Driver.new(app, browser: :remote, url: url, desired_capabilities: caps)
end

# Capybara.javascript_driver = :chrome_headless

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    driven_by :selenium_container
    
    Capybara.server_host = IPSocket.getaddress('app')
    Capybara.server_port = 3002
    Capybara.app_host = "http://#{Capybara.server_host}:#{Capybara.server_port}"
    
    # if ENV["SELENIUM_DRIVER_URL"].present?
    #   driven_by :selenium, using: :chrome, options: {
    #     browser: :remote,
    #     url: ENV.fetch("SELENIUM_DRIVER_URL"),
    #     desired_capabilities: :chrome
    #   }
    # else
    #   driven_by :selenium_chrome_headless
    # end
  end
end
