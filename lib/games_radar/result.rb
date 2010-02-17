module GamesRadar
  class Result
    # The total rows returned by the API
    attr_reader :count

    # The total pages
    attr_reader :pages

    # The items array
    attr_reader :items

    # The number of items per page
    attr_reader :page_size

    # Initialize a GamesRadar::Result by using a hash.
    def initialize(options = {})
      options.each do |name, value|
        instance_variable_set("@#{name}", value)
      end

      calculate_page_size
    end

    # A shortcut for <tt>GamesRadar::Result#items.each</tt>
    def each(&block)
      items.each do |item|
        yield item
      end
    end

    # A shortcut for <tt>GamesRadar::Result#items.each_with_index</tt>
    def each_with_index(&block)
      items.each_with_index do |item, i|
        yield item, i
      end
    end

    def calculate_page_size # :nodoc:
      if items.size == 0
        @pages = 0
      else
        @pages = (count.to_f / page_size).ceil
      end
    end
  end
end
