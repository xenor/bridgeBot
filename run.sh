#!/usr/bin/env ruby
# bridge bot
# FILES:
# - run.sh              the file for running
# - core.class.rb       the file for the core class
# - cmd.class.rb        the file for the command parser class

require 'socket'
require 'core.class.rb'
require 'cmd.class.rb'

# config
$server_host = "farmer.freenode.net"
$server_port = 6667

# init commandline parser
$cmd = Cmd.new

# init Core
$core = Core.new
$core.init

while $core.online
    line = $core.get
    cmd = line.split "\r\n"
    cmd.each do |str|
        $core.say("[\e[1;32m<<<\e[0m]: #{str}")
        $cmd.parse str
    end
end
