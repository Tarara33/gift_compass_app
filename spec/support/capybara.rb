RSpec.configure do |config|
  config.before(:each, type: :system) do
    #driven_by :rack_test
    driven_by :selenium_chrome_headless
    #driven_by :selenium_chrome
    Capybara.page.current_window.resize_to(1280, 800)
  end
end