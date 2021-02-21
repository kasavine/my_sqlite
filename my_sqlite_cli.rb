require 'readline'
require_relative "my_sqlite_request"

legal_start_points = ["SELECT", "UPDATE", "INSERT", "DELETE"]

def readline_and_split
    line = Readline.readline('> ', true)
    return nil if line.nil?
    if line =~ /^\s*$/ or Readline::HISTORY.to_a[-2] == line
        Readline::HISTORY.pop
    end
    line.split(" ")
end

commands = []
arguments = []

while line = readline_and_split
    # p Readline::HISTORY.to_a

    if line
        commands << line[0]
        1.upto line.length - 1 do |arg|
            arguments << line[arg]
        end
    end

    p commands
    p arguments
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