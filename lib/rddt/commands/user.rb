require 'io/console'

module Rddt
	class Command::User < Rddt::Command

		desc "signin", "Starts the login process"
		def signin

			redditUser = Rddt::Reddit::User.new(*args)

      if redditUser.is_signed_in?
        puts "Already signed in"
      else
        puts "Please login with your Reddit username and password"
        print "Username: "
        username = STDIN.gets.chomp
        print "\n"
        print "Password: "
        password = STDIN.noecho(&:gets).chomp

        if redditUser.sign_in(username, password)
          puts "Signed in succesfully. Welcome #{redditUser.get_username}"
        else
          puts "Invalid credentials. Please try again."
        end
      end

    end

    desc "signout", "Removes user credentials from netrc file"
    def signout
      redditUser = Rddt::Reddit::User.new(*args)
      redditUser.sign_out

      puts "Signed out succesfully"
    end

    desc "karma TYPE", "Returns karma of TYPE"
    def karma(type)

      redditUser = Rddt::Reddit::User.new

      if redditUser.login_credentials_exist?
        if redditUser.sign_in(redditUser.get_login_credentials)
          karma = redditUser.get_karma(type)

          if karma != nil
            puts "Your #{type} karma is #{karma}"
          else
            puts "Invalid karma type"
          end
        else
          puts "Login credentials invalid"
        end
      else
        puts "Please sign in first"
      end
    end
	end
end