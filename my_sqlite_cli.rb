require 'readline'
require_relative "my_sqlite_request"

def readline_with_hist_management
    line = Readline.readline('our-awesome-cli> ', true)
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
        action, *args = command.split(" ")
        action = action.downcase()
        if action == "select"
           result[action] = args
        elsif action == "from"
            if result['select'] != nil
                result[action] = args
            end
        elsif action == 'run'
            return result
        end
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
        request.run
    end
end
run_request

=begin

FROM table
INSERT table
UPDATE table

SELECT *
SELECT column
SELECT col1, col2, col3

JOIN table ON col_a=col_b

WHERE col=val

DELETE ??

ORDER col DESC/ASC

SET col1=val1, col2=val2

VALUES ??

=end