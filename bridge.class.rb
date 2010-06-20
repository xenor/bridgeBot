# bridge.class.rb
class Bridge
    def initialize(server,port,name)
        @name = name
        @sock = TCPSocket.open(server,port)
        $socks = $socks + [@sock]
        $bridges = $bridges += [self]
        put "USER #{$bot_ident} * * :#{$bot_realname}"
        put "NICK #{$bot_nick}"
        @online = true
        @writer = []
    end
    
    def put str
        $core.say("[#{@name}]\t[\e[1;31m>>>\e[0m]: #{str}")
        @sock.send("#{str}\r\n",16000)
    end
    
    def get
        line = @sock.recv(16000).strip
        return line
    end
    
    def getSock
        return @sock
    end
    
    def getName
        return @name
    end
    
    def writer name
        @writer.include? name
    end
    
    def addName name
        @writer += [name]
    end
    
    def delName name
        @writer -= [name]
    end
end

class BridgeParser
    def parse(sock,str)
        # parse incoming command
        # split it by a whitespace
        cmd = str.split ' '
        if(cmd[0] == "PING")
            # its just a ping...
            # => send pong
            sock.put "PONG #{cmd[1]}"
        elsif(cmd[1] == "PRIVMSG")
            writer = $m.getWriter cmd[0]
            if(sock.writer(writer))
                msg = $m.findDP(str[1..-1])
                $m.privmsg('#crapcode',"<#{writer}>\t#{msg}")
            end
        elsif(cmd[1] == "376")
            $m.privmsg('#crapcode','Connection established.')
        end
    end
end
