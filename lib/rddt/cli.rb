module Rddt
	class CLI < Rddt::Command

    #Shortcuts for common user commands
		command_alias signin: 'user:signin'
		command_alias signedin: 'user:signedin'
		command_alias signout: 'user:signout'
    command_alias karma: 'user:karma'

    #Shotcuts for common page commands
    command_alias front: 'page:front'

	end
end