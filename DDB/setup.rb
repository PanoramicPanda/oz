

ENV['OZ_APP_NAME'] = 'D&D Beyond'
ENV['OZ_CONFIG_DIR'] = "#{File.dirname(__FILE__)}/config"

require_relative '../CORE/setup.rb'

require_all('../DDB/overrides/elements')

require_relative '../DDB/pages/ddb_root_page.rb'
recursively_require_all_base_pages('../DDB/pages')
recursively_require_all_edge_pages('../DDB/pages')

require_all('../DDB/step_definitions') if defined?(Cucumber)