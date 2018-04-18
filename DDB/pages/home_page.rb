class HomePage < DDBRootPage
  add_id_element(:link, /READ MORE/, xpath: '/html/body/div[1]/div/div[2]/div/section/div/div[1]/div[1]/div/div/ul/li[1]/article/div/div[3]/div[4]/a')

  def on_page_load
    super
    perform_sign_in unless @world.ledger.logged_in
  end

  def perform_sign_in
    click_on(:log_in_button)
    @world.browser.iframe(:name => 'passport').text_field(:id => 'username').set 'PLACEHOLDER - Never stick this on GitHub/Anywhere Public'
    @world.browser.iframe(:name => 'passport').text_field(:name => 'password').set 'PLACEHOLDER - Seriously - you should not stick this online'
    @world.browser.iframe(:name => 'passport').button(:xpath => '//*[@id="loginForm"]/div[3]/button').click
    @world.ledger.save_object(:logged_in, true)
  end


end