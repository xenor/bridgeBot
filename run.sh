#!/usr/bin/env ruby
# bridge bot
# FILES:
# - run.sh              the file for running
# - core.class.rb       the file for the core class
# - cmd.class.rb        the file for the command parser class
# - config.rb           configuration file
# - m.class.rb          the home of the m class - the modification class
# - bridge.class.rb     the home of the bridging class

require 'socket'
require 'core.class.rb'
require 'cmd.class.rb'
require 'config.rb'
require 'm.class.rb'
require 'bridge.class.rb'

$curchans = []
$socks = []
$bridges = []
$bridge = BridgeParser.new

# init modification class
$m = M.new

# init commandline parser
$cmd = Cmd.new

# init Core
$core = Core.new
$core.init

while $core.online
    r,w,e = select($socks,nil,nil,nil)
    r.each do |sock|
        if(sock == $mainsock)
            line = $core.get
            cmd = line.split "\r\n"
            cmd.each do |str|
                $core.say("[\e[1mMAIN\e[0m]\t[\e[1;32m<<<\e[0m]: #{str}")
                $cmd.parse str
            end
        else
            core = $core.getBridgeBySock sock
            line = core.get
            cmd = line.split "\r\n"
            cmd.each do |str|
                $core.say("[#{core.getName}]\t[\e[1;32m<<<\e[0m]: #{str}")
                $bridge.parse(core,str)
            end
        end
    end
end
