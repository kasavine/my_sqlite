require 'readline'
require_relative "my_sqlite_request"

legal_start_points = ["SELECT", "UPDATE", "INSERT", "DELETE"]


def readline_with_hist_management
    line = Readline.readline('> ', true)
    return nil if line.nil?
    if line =~ /^\s*$/ or Readline::HISTORY.to_a[-2] == line
        Readline::HISTORY.pop
    end
    line
end

def parse_request
    action = ""
    args = []
    result = Hash.new
    while command = readline_with_hist_management
        if command == ""
            return result
        end
        action, *args = command.split(" ")
        action = action.downcase()
        if action == "select"
           result[action] = args
        elsif action == "from"
            if result['select'] != nil
                result[action] = args
            end
        end
        # p action
        # p args
        result
    end
end
    
def run_request
    commands = parse_request
    if commands != nil
        request = MySqliteRequest.new
        # request.from('db.csv').select(['name', 'age']).run
        commands.each do |action, args|
            case action
            when "from"
                request.from(args[0])
            when "select"
                request.select(args)
            end
        end
        p request.run
    end
end
run_request

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
INSERT table
UPDATE table

SELECT column
SELECT col1, col2, col3

JOIN table ON col_a=col_b

WHERE col=val

DELETE ??

ORDER col DESC/ASC

SET col1=val1, col2=val2

VALUES ??

=end