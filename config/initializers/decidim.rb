# frozen_string_literal: true

Decidim.configure do |config|
  config.application_name = "OpenHeritage Participatory Platform"
  config.mailer_sender = "OH Notifications <noreply@labs.openheritage.eu>"

  # Change these lines to set your preferred locales
  config.default_locale = :en
  config.available_locales = [:en, :ca, :es, :fr, :pt, :de, :fi, :nl, :eu, :ca, :gl, :hu, :it, :pl, :sv]

  # Geocoder configuration
  config.geocoder = {
    # static_map_url: "https://image.maps.cit.api.here.com/mia/1.6/mapview",
  #   here_app_id: Rails.application.secrets.geocoder[:here_app_id],
  #   here_app_code: Rails.application.secrets.geocoder[:here_app_code]
    static_map_url: "https://static-maps.yandex.ru/1.x",
    here_app_id: nil,
    here_app_code: nil
  }

  if Decidim.geocoder.present?
    Geocoder.configure(
      # geocoding service (see below for supported options):
      lookup: :nominatim,
      # IP address geocoding service (see below for supported options):
      # :ip_lookup => :maxmind,
      # to use an API key:
      # api_key: [Decidim.geocoder&.fetch(:here_app_id), Decidim.geocoder&.fetch(:here_app_code)]
      # geocoding service request timeout, in seconds (default 3):
      # :timeout => 5,
      # set default units to kilometers:
      # :units => :km,
      # caching (see below for details):
      # :cache => Redis.new,
      # :cache_prefix => "..."
    )
  end

  # Custom resource reference generator method
  # config.reference_generator = lambda do |resource, component|
  #   # Implement your custom method to generate resources references
  #   "1234-#{resource.id}"
  # end

  # Currency unit
  # config.currency_unit = "€"

  # The number of reports which an object can receive before hiding it
  # config.max_reports_before_hiding = 3

  # Custom HTML Header snippets
  #
  # The most common use is to integrate third-party services that require some
  # extra JavaScript or CSS. Also, you can use it to add extra meta tags to the
  # HTML. Note that this will only be rendered in public pages, not in the admin
  # section.
  #
  # Before enabling this you should ensure that any tracking that might be done
  # is in accordance with the rules and regulations that apply to your
  # environment and usage scenarios. This component also comes with the risk
  # that an organization's administrator injects malicious scripts to spy on or
  # take over user accounts.
  #
  config.enable_html_header_snippets = false
end

Rails.application.config.i18n.available_locales = Decidim.available_locales
Rails.application.config.i18n.default_locale = Decidim.default_locale
