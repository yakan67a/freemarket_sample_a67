require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module FreemarketSampleA67
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.generators do |g|
      g.stylesheets false
      g.javascripts false
      g.helper false
      g.test_framework false
    end
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.i18n.default_locale = :ja
    config.action_view.field_error_proc = Proc.new do |html_tag, instance|
      if instance.kind_of?(ActionView::Helpers::Tags::Label)
        html_tag.html_safe
      else
        method_name = instance.instance_variable_get(:@method_name)
        errors = instance.object.errors[method_name]

        html = <<~EOM
          <div class=error>#{html_tag}
            <div class="has_error" id="#{method_name}_error">
              #{I18n.t("activerecord.attributes.#{instance.object.class.name.underscore}.#{method_name}")}
              #{errors.first}
            </div>
          </div>
        EOM
        html.html_safe
      end
    end
  end
end
