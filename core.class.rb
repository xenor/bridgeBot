# core.class.rb
# part of the bridge irc bot

class Core
    def init
        @sock = TCPSocket.open($server_host,$server_port)
        $socks = $socks + [@sock]
        $mainsock = @sock
        put "USER #{$bot_ident} * * :#{$bot_realname}"
        put "NICK #{$bot_nick}"
        @online = true
    end
    
    def online
        return @online
    end
    
    def say str
        puts "#{Time.new.to_s}: #{str}"
    end
    
    def put str
        say("[\e[1mMAIN\e[0m]\t[\e[1;31m>>>\e[0m]: #{str}")
        @sock.send("#{str}\r\n",16000)
    end
    
    def get
        line = @sock.recv(16000).strip
        return line
    end
    
    def getBridgeBySock sock
        $bridges.each do |tmp|
            if tmp.getSock == sock
                return tmp
            end
        end
    end
    
    def getBridgeByName name
        $bridges.each do |tmp|
            if tmp.getName == name
                return tmp
            end
        end
    end
end
