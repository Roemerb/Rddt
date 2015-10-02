require "redditkit"

module Rddt
	class Rddt::Reddit
		def initialize
			@client = RedditKit::Client.new
		end
	end
end
