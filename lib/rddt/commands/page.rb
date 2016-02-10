require 'ap'
require 'terminfo'

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

        longestSubredditLength = 0;
        frontPagePosts.each do |post|
          if (post[:subreddit].length > longestSubredditLength)
            longestSubredditLength = post[:subreddit].length
          end
        end


        termSize = TermInfo.screen_size
        frontPagePosts.each do |post|

          toPrint = "\e[1;30;47m#{post[:subreddit].ljust(longestSubredditLength)}\e[0m" +
                    "\e[1;32;40m#{post[:score]}\e[0m" +
                    "\e[1;30;47m#{post[:title]}\e[0m"

          if (toPrint.length > termSize[1])
            toPrint = "\e[1;30;47m#{post[:subreddit].ljust(longestSubredditLength)}\e[0m" +
                "\e[1;32;40m#{post[:score]}\e[0m"

            if (toPrint.length < termSize[1])
              subString = post[:title][0..termSize[1]-toPrint.length]
              toPrint = toPrint + "\e[1;30;47m#{subString[0..subString.length-3]}...\e[0m"
            end
          end

          print toPrint + "\n"

        end
      else
        puts "Authentication problem. Did you sign in?"
      end
    end
  end
end