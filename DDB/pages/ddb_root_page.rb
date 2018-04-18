class DDBRootPage < CorePage

  add_route(:HomebrewCreationsPage, :navigate_to_homebrew_creations)

  def begin_new_session
    browser.goto(@world.configuration['ENVIRONMENT']["URL"])
    @world.ledger.save_object(:logged_in, false)
    @world.assert_and_set_page(HomePage)
  end

  def create_common_elements
    @log_in_button = add_button(:log_in, element_type: :link, id: 'login-link')
    create_nav_bar
  end

  def create_nav_bar
    @my_content_link = add_button(:my_content, element_type: :li, id: 'nav-my-content')

    @homebrew_creations_link = add_button(:homebrew_creations, element_type: :li, id: 'nav-homebrew-creations')
    @homebrew_creations_link.deactivate

    @my_content_link.on_hover do
      @homebrew_creations_link.activate
    end
  end

  def navigate_to_homebrew_creations
    @my_content_link.hover
    @homebrew_creations_link.click
  end

  def on_page_load
    @log_in_button.activate_if(!@world.ledger.logged_in)
  end

end