module Rddt
  class Reddit::Page < Rddt::Reddit

    def initialize
      super
    end

    def get_front_page_posts
      @client.front_page
    end

  end
end