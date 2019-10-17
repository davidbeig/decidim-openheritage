# frozen_string_literal: true
# Add images to proposals cars
#

Rails.application.config.to_prepare do

  # Show images in proposals if they have galleries
  Decidim::Proposals::ProposalMCell.class_eval do
    def has_image?
      model.photos.any?
    end

    def resource_image_path
      model.photos.first.thumbnail_url
    end
  end

  # Parse markdown content if official proposals
  Decidim::Proposals::ProposalPresenter.class_eval do
    def body(links: false, extras: true, strip_tags: false)
      renderer = Decidim::ContentRenderers::HashtagRenderer.new(proposal.body)
      body = renderer.render(links: links, extras: extras, strip_tags: strip_tags).html_safe
      if proposal.try(:official?)
        body = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true).render(body)
      end
      body
    end
  end

  Decidim::StaticMapGenerator.class_eval do
    def uri
      params = {
        ll: "#{@resource.longitude},#{@resource.latitude}",
        lang: "en-US",
        l: "map",
        z: @options[:zoom],
        size: "#{@options[:width]},#{@options[:height]}"
      }

      URI.parse(Decidim.geocoder.fetch(:static_map_url)).tap do |uri|
        uri.query = URI.encode_www_form params
      end
    end
  end
end