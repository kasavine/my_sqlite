require 'readline'
require_relative "my_sqlite_request"

legal_start_points = ["SELECT", "UPDATE", "INSERT", "DELETE"]


def readline_with_hist_management
    line = Readline.readline('> ', true)
    return nil if line.nil?
    if line =~ /^\s*$/ or Readline::HISTORY.to_a[-2] == line
        Readline::HISTORY.pop
        p "READLINE"
    end
    line
end



def parse_string()
    action = ""
    args = []
    
    request = MySqliteRequest.new
    
    while command = readline_with_hist_management
        action,*args = command.split(" ")
        action = action.downcase()
        request_hash = Array.new
        
        if action == "select"
            p request_hash << {action => args}
        
        elsif action == "from"
            if request_hash == nil
                return "error: SELECT action required to do FROM"
            end
            p request_hash << {action => args}
        
            #[{select : age, old, word}, {from : this place}]
        elsif action == "insert"
            p action
    
        elsif action == "update"
    
        elsif action == "delete"
    
        elsif action == "quit"
            #end the while loop and run the request
            next
        end
        p "commands here: " + command
        p args
    end
    p "THIS SHOULD PRINT"
end

parse_string()

# 1: COMMAND_NOT_FOUND  
# 2: FROM_NOT_FOUND
# 3: WHERE_NOT_FOUND
# 4: JOIN_NOT_FOUND

# while buf = Readline.readline("> ", true)
# p Readline::HISTORY.to_a
# print("-> ", buf, "\n")

# if COMMAND_NOT_FOUND
# command = buf.split(" ")[0]
# if command invalid show error
# state => FROM_NOT_FOUND

# if FROM_NOT_FOUND
# from = buf
# WHERE_NOT_FOUND
# end



=begin

FROM table
INSERT into table
UPDATE table

SELECT column
SELECT col1, col2, col3

JOIN table ON col_a=col_b

WHERE col=condition

DELETE ??

ORDER col DESC/ASC

SET col1=val1, col2=val2

VALUES ??

=end