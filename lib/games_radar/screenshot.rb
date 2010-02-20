module GamesRadar
  class Screenshot
    # The screenshot page on GamesRadar[http://gamesradar.com]
    attr_reader :url

    # The thumbnail url
    attr_reader :thumbnail

    # The large image url
    attr_reader :image

    # When the screenshot was published on GamesRadar[http://gamesradar.com]
    attr_reader :published_at

    def self.initialize_with_node(node) # :nodoc:
      thumbnail = node.at("thumbnail").text
      image = thumbnail.gsub(/screenshot_small\.jpg/, "screenshot_viewer_medium.jpg")

      new(
        {
          :url => node.at("url").text,
          :thumbnail => thumbnail,
          :image => image,
          :published_at => Time.parse(node.at("published_date").text)
        }
      )
    end

    # Initialize a new screenshot object and set the hash to its attributes.
    #
    #   GamesRadar::Screenshot.new(
    #     :url => "/some/url",
    #     :image => "/some/image.jpg"
    #   )
    def initialize(attrs = {})
      attrs.each do |name, value|
        instance_variable_set("@#{name}", value)
      end
    end
  end
end
