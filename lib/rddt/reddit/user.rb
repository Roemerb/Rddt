require 'netrc'

module Rddt
  class Reddit::User < Rddt::Reddit

    def initialize
      super
    end

    def sign_in(username = nil, password = nil)
      n = Netrc.read
      savedUser, savedPass = n["reddit.com"]

      if savedUser == nil || savedPass == nil || savedUser == "" || savedPass == ""
        if username != nil && password != nil
          @client.sign_in(username, password)

          if @client.signed_in?
            n["reddit.com"] = username, password
            n.save
            true
          else
            false
          end
        else
          false
        end
      else
        @client.sign_in(savedUser, savedPass)

        @client.signed_in?
      end
    end

    def login_credentials_exist?
      n = Netrc.read

      user, pass = n["reddit.com"]

      if user == nil || pass == nil || user == "" || pass == ""
        false
      else
        true
      end
    end

    def get_login_credentials
      n = Netrc.read

      user, pass = n["reddit.com"]

      return user, pass
    end

    def is_signed_in?
      @client.signed_in?
    end

    def sign_out
      n = Netrc.read
      n.delete "reddit.com"
      n.save
    end

    def get_username
      @client.user[:name]
    end

    def get_authenticated_client
      if self.login_credentials_exist?
        if self.sign_in(self.get_login_credentials)
          @client
        else
          false
        end
      else
        false
      end
    end

    def get_karma(type)
      if type == "comment"
        @client.user[:comment_karma]
      elsif type == "link"
        @client.user[:link_karma]
      else
        nil
      end
    end
  end
end
