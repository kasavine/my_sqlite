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
        left, right = arr[i].split("=")
        result[left] = right
        i += 1
    end
    return result
end

def run_request
    request = MySqliteRequest.new
    # execute = false
    while command = readline_with_hist_management
        if command == "run"
            request.run
        end
        # if command[command.length - 1] == ";"
        #     command = command.split(";")[0]
        #     execute = true
        # end
        action, *args = command.split(" ") # ["name,", "age"]
        args = args.join(" ").split(", ") # "name, age" ", "
        action = action.downcase

        case action
        when "from"
            if args.length != 1
                puts "Provide one existing table. Ex.: table.csv"
            else
                request.from(*args)
            end
        when "select"
            if args.length < 1
                puts "Provide a column or columns. Ex.: name, age"
            else
                request.select(args)
            end
        
        when "where"
            if args.length != 2
                puts "Provide condtions to look for. Ex.: age=20"
            else
                request.where(*args)
            end

        when "order"
            if args.length != 2
                p "Provide column and type. Ex.: age, ASC" # age ASC
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
                puts "Provide some data to insert. Ex.: name=BOB, birth_state=CA, age=90"
            else
                request.values(array_to_hash(args)) # -> data -> hash
            end

        when "update"
            if args.length != 1
                puts "Provide one existing table. Ex.: table.csv"
            else
                request.update(*args)
            end

        when "set"
            if args.length < 1
                puts "Provide some data to update. Ex.: name=BOB"
            else
                request.set(array_to_hash(args)) 
            end

        when "delete"
            if args.length != 1
                # conditional statement to confirm deletion of table
                puts "Provide one existing table. Ex.: table.csv! Use WHERE clause to choose record"
            else
                request.delete(*args)
            end
        else
            puts "Work in progress, don't have this statement yet :)"
        end

        # if execute == true
        #     exectue = false
        #     request.run
        # end
    end
end

run_request