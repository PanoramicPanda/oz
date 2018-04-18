class HomePage < DDBRootPage
  add_id_element(:link, /READ MORE/, xpath: '/html/body/div[1]/div/div[2]/div/section/div/div[1]/div[1]/div/div/ul/li[1]/article/div/div[3]/div[4]/a')

  def create_elements
    login_elements

  end

  def login_elements
    # username = add_text_field(:username, id: 'username')
    username = add_text_field(:username, xpath: '//*[@id="username"]')
    password = add_text_field(:password, id: 'password')
    submit_log_in = add_button(:submit_log_in, xpath: '//*[@id="loginForm"]/div[3]/button')
    @login_elements = group(username, password, submit_log_in)
    @login_elements.deactivate
  end

  def on_page_load
    super
    perform_sign_in unless @world.ledger.logged_in
  end

  def perform_sign_in
    click_on(:log_in_button)
    @login_elements.activate
    @world.browser.switch.frame('passport') # TODO: Switch to this iFrame....GRRR
    fill('TWITCH_LOGIN')
    click_on(:submit_log_in_button)
    @login_elements.deactivate
    @world.ledger.save_object(:logged_in, true)
  end


end