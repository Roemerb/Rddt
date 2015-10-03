module Rddt
  class Command::Page < Rddt::Command
    desc "front", "Shows front page"
    def front
      redditUser = Rddt::Reddit::User.new

      if client = redditUser.get_authenticated_client
        frontPagePosts = client.front_page

        frontPagePosts.each do |post|
          #ANSI escape sequence to print subreddit with white background
          print "\e[1;30;47m#{post[:subreddit]}\e[0m"
          #ANSI escape sequence to print title in bold
          print "\e[1m#{post[:title]}\e[0m"
          #End the line
          print "\n"
        end
      else
        puts "Authentication problem. Did you sign in?"
      end
    end
  end
end