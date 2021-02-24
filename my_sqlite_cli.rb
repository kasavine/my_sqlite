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

def run_request_trtl_edition
    request = MySqliteRequest.new
    while command = readline_with_hist_management
        if command == ""
            p request.run
            return
        end
        action, *args = command.split(" ")
        action = action.downcase()
        case action

        when "from"
            request.from(*args)
        
        when "select"
            request.select(args)
        
        when "insert"
            request.insert(*args)
        
        when "values"
            request.values(to_h(args))
        
        when "where"
            request.where(*args)
        
        when "order"
            if args.length < 2
                p "wrong format for order - e.g. ORDER column DESC"
            end
            col_name = args[0]
            if args[1].downcase != "asc" && args[1].downcase != "desc"
                p "Provide type of sorting ... ASC or DESC"
            end
            request.order(args[1], col_name)
        end
    end
end

def to_h(arr)
    result = Hash.new
    i = 0
    while i < arr.length 
        result[arr[i]] = arr[i + 1]
        i += 2
    end
    return result
end
    
run_request_trtl_edition