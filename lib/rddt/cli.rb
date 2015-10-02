module Rddt
	class CLI < Rddt::Command

		command_alias signin: 'user:signin'
		command_alias signedin: 'user:signedin'
		command_alias signout: 'user:signout'
    command_alias karma: 'user:karma'

	end
end