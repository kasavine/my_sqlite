require 'readline'
require_relative "my_sqlite_request"

legal_start_points = ["SELECT", "UPDATE", "INSERT", "DELETE"]


def readline_with_hist_management
    line = Readline.readline('> ', true)
    return nil if line.nil?
    if line =~ /^\s*$/ or Readline::HISTORY.to_a[-2] == line
        Readline::HISTORY.pop
        p "READLINE"
        line.split(" ")
    end
end

commands = []
args = []
while line = readline_with_hist_management
    # Maybe here could besomething like 
    # if line.shift == "SELECT"
    #commands = line.shift()
    # end
    # while line
    #     args = command.shift()
    #end 
    if line == "SELECT"
        p line[0]
        commands << line[0]
        1.upto line.length - 1 do |arg|
            # args << line[arg]
        end
    end
    p "commands here: " + commands 
    p "args here: " + args
end

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