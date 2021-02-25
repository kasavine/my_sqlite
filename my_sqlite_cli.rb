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

def array_to_hash(arr)
    result = Hash.new
    i = 0
    while i < arr.length 
        result[arr[i]] = arr[i + 1]
        i += 2
    end
    return result
end

def run_request
    request = MySqliteRequest.new
    while command = readline_with_hist_management
        if command == "run"
            request.run
        end
        action, *args = command.split(" ") # ["name,", "age"]
        args = args.join(" ").split(", ") # "name, age" ", "
        action = action.downcase
        # p action

        case action
        when "from"
            if args.length != 1
                puts "Provide one existing table. Ex.: table.csv"
            else
                request.from(*args)
            end
        when "select"
            if args.length < 1
                puts "Provide a column or columns. Ex.: name age"
            else
                request.select(args)
            end
        
        when "where"
            if args.length != 2
                puts "Provide condtions to look for. Ex.: age 20"
            else
                request.where(*args)
            end

        when "order"
            if args.length != 2
                p "Provide column and type. Ex.: age ASC"
            else
                col_name = args[0]
                sort_type = args[1].downcase
                request.order(sort_type, col_name)
            end

        when "insert"
            if args.length != 1
                puts "Provide one existing table. Ex.: table.csv"
            else
                request.insert(*args)
            end
        
        when "values"
            if args.length < 1
                puts "Provide some data to insert. Ex.: "
            else
                request.values(array_to_hash(args)) # -> data -> hash
            end

        end
    end
end

run_request