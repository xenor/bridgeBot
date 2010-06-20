# m.class.rb
class M
    def join chan
        $core.put "JOIN #{chan}"
        $curchans + [chan]
    end
    def part chan
        $core.put "PART #{chan}"
        $curchans - [chan]
    end
    
    def findDP str
        dp = (str[1..-1].index(":")) + 2
        tmp = str[dp..-1]
        return tmp
    end
    
    def privmsg (target,msg)
        $core.put "PRIVMSG #{target} :#{msg}"
    end
    
    def getWriter cmd
        i = (cmd.index('!') - 1)
        return cmd[1..i]
    end
end
