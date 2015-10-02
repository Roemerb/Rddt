require 'thor'

module Rddt
	class Command < Thor
		def self.command_alias(map)
			map.each do |name, command|
				desc name.to_s, "shortcut for #{command}"
				define_method name do |*args|
					invoke "rddt:command:#{command}", args
				end
			end
		end
	end
end