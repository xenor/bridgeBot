# cmd.class.rb
class Cmd
    def parse str
        # parse incoming command
        # split it by a whitespace
        cmd = str.split ' '
        if(cmd[0] == "PING")
            # its just a ping...
            # => send pong
            $core.put "PONG #{cmd[1]}"
        elsif(cmd[1] == "PRIVMSG")
            # its a privmsg
            # => parse it
            parsePRIVMSG str
        elsif(cmd[1] == "376")
            $channels.each do |chan|
                $m.join chan
            end
        end
    end
    
    def parsePRIVMSG str
        tmp = $m.findDP str
        cmd = tmp.split ' '
        if (cmd[0] == $t + 'eval')
            eval(cmd[1..-1].join ' ')
        elsif( cmd[0] == $t + 'join')
            cmd[1..-1].each do |chan|
                $m.join chan
            end
        elsif( cmd[0] == $t + 'part')
            cmd[1..-1].each do |chan|
                $m.part chan
            end
        elsif( cmd[0] == $t + 'bridge')
            $socks + [Bridge.new(cmd[1],cmd[2],cmd[3])]
        elsif( cmd[0] == $t + 'put' )
            core = $core.getBridgeByName cmd[1]
            core.put "#{cmd[2..-1].join ' '}"
        elsif( cmd[0] == $t + 'add' )
            core = $core.getBridgeByName cmd[1]
            core.addName cmd[2]
        end
    end    
end
