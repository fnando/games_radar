module GamesRadar
  module Request
    # The base url points to the latest API version.
    BASE_URL = "http://api.gamesradar.com"

    # Genre values that should be replaced for a more textual equivalent.
    GENRE = {
      :children => "children's",
      :other    => "other games/compilations",
      :rpg      =>  "role playing",
      :sports   => "sport games"
    }

    # Sort values that should be replaced for the expected API value.
    SORT = {
      :asc => "a-z",
      :desc => "z-a"
    }

    # Replace pretty params name for its ugly counter-part.
    PARAMS = {
      :page   => :page_num,
      :size   => :page_size,
      :filter => :game_name
    }

    # Make a API request processing the provided parameters and
    # merging the API key in every request.
    #
    #   include GamesRadar::Request
    #
    #   request "/game", :id => "2005120717014294613647" do |xml|
    #     # do whatever you want with the response XML
    #   end
    def request(path, params = {}, &block)
      uri = uri_for(path, params.dup)
      xml = Nokogiri::XML(open(uri).read)

      handle_exceptions! xml

      yield xml
    end

    # Raise exception when XML contains known error codes
    def handle_exceptions!(xml) # :nodoc:
      case xml.search("error > code").inner_text.to_i
      when 10001 then raise GamesRadar::InvalidApiKeyError
      end
    end

    # Generate a URI based on the specified path and params.
    def uri_for(path, params) # :nodoc:
      prepare_params!(params)
      prepare_named_params!(path, params)

      URI.parse [File.join(BASE_URL, path), to_query_string(params)].join("?")
    end

    # Convert to query string.
    # Value is already escaped by the <tt>prepare_params!</tt> method.
    def to_query_string(params) # :nodoc:
      params = params.collect do |name, value|
        "%s=%s" % [CGI.escape(name.to_s), value]
      end

      params.join("&")
    end

    # Modify the specified params hash by escaping each of its values.
    # Also merge the API key into this params hash.
    def prepare_params!(params) # :nodoc:
      raise GamesRadar::InvalidApiKeyError unless GamesRadar::Config.api_key

      params.merge!(:api_key => GamesRadar::Config.api_key)

      params.each do |name, value|
        name = PARAMS[name.to_sym] || name.to_sym
        value = value.to_s.to_sym

        case name
        when :genre then
          value = GENRE[value] if GENRE[value]
        when :sort then
          value = SORT[value] if SORT[value]
        end

        params.merge!(name => CGI.escape(value.to_s))
      end

      # Remove options that are replaced
      [:page, :size, :filter].each do |param|
        params.delete(param) && params.delete(param.to_s)
      end
    end

    # Replace a named param for its value on the specified path.
    def prepare_named_params!(path, params) # :nodoc:
      path.gsub!(/(:[a-z0-9]+)/) do |param|
        param = param.gsub(/:/, "").to_sym
        params.delete(param)
      end
    end
  end
end
