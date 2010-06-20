# core.class.rb
# part of the bridge irc bot

class Core
    def init
        @sock = TCPSocket.open($server_host,$server_port)
        @online = true
    end
    
    def online
        return @online
    end
    
    def say str
        puts "#{Time.new.to_s}: #{str}"
    end
    
    def get
        line = @sock.recv(1024).strip
        return line
    end
end
