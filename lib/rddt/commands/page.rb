require 'pp'

module Rddt
  class Command::Page < Rddt::Command
    desc "front LIMIT", "Shows LIMIT number of front page posts"
    def front(limit=25.to_i)

      # Command line arguments are strings by default
      limit = limit.to_i

      if limit > 100
        abort("Limit can't be higher than 100")
      end

      redditUser = Rddt::Reddit::User.new

      if client = redditUser.get_authenticated_client
        frontPagePosts = client.front_page({:limit => limit})

        frontPagePosts.each do |post|
          #ANSI escape sequence to print subreddit with white background
          print "\e[1;30;47m#{post[:subreddit].ljust(20)}\e[0m"
          #ANSI escape sequence to print the upvotes
          print "\e[1;32;40m#{post[:score]}\e[0m"
          #ANSI escape sequence to print title in bold
          print "\e[1;30;47m#{post[:title]}\e[0m"
          #End the line
          print "\n"
        end
      else
        puts "Authentication problem. Did you sign in?"
      end
    end
  end
end