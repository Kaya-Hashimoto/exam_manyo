require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module TaskExam
  class Application < Rails::Application
    config.load_defaults 6.1
    config.time_zone = 'Asia/Tokyo'
    config.active_record.default_timezone = :local
    config.i18n.default_locale = :ja
    config.generators do |g|
      g.test_framework :rspec,
                      model_specs: true,
                      view_specs: false,
                      helper_specs: false,
                      routing_specs: false,
                      vontroller_specs: false,
                      request_specs: false
    end
  end
end
