require 'readline'
require_relative "my_sqlite_request"

def readline_with_hist_management
    line = Readline.readline('our-awesome-cli> ', true)
    # return nil if line.nil?
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

def process_action(action, args, request)
    # p action
    case action
    when "from"
        if args.length != 1
            puts "Ex.: FROM db.csv"
            return
        else
            request.from(*args)
        end
    when "select"
        if args.length < 1
            puts "Ex.: SELECT name, age"
            return
        else
            request.select(args)
        end
    when "where"
        if args.length != 1
            puts "Ex.: WHERE age=20"
        else
            col, val = args[0].split("=")
            request.where(col, val)
        end
    when "order"
        if args.length != 2
            p "Ex.: ORDER age ASC"
        else
            col_name = args[0]
            sort_type = args[1].downcase
            request.order(sort_type, col_name)
        end
    when "join"
        if args.length != 3
            puts "Do better. Ex.: JOIN table ON col_a=col_b"
        elsif args[1] != "ON"
            puts "Provide ON statement. Ex.: JOIN table ON col_a=col_b"
            return
        else
            table = args[0]
            col_a, col_b = args[2].split("=")
            request.join(col_a, table, col_b)
        end
    when "insert"
        if args.length != 1
            puts "Ex.: INSERT db.csv. Use VALUES"
        else
            request.insert(*args)
        end
    when "values"
        if args.length < 1
            puts "Provide some data to insert. Ex.: name=BOB, birth_state=CA, age=90"
        else
            request.values(array_to_hash(args))
        end
    when "update"
        if args.length != 1
            puts "Ex.: UPDATE db.csv"
        else
            request.update(*args)
        end
    when "set"
        if args.length < 1
            puts "Ex.: SET name=BOB. Use WHERE - otherwise WATCH OUT."
        else
            request.set(array_to_hash(args)) 
        end
    when "delete"
        if args.length != 0
            # conditional statement to confirm deletion of table
            puts "Ex.: DELETE FROM db.csv! Use WHERE - otherwise WATCH OUT."
        else
            request.delete 
        end
    else
        puts "Work in progress, don't have this statement yet :)"
        puts "If you want to quit - type quit."
    end
end

def execute_request(sql)
    valid_actions = ["SELECT", "FROM", "JOIN", "WHERE", "ORDER", "INSERT", "VALUES", "UPDATE", "SET", "DELETE"]
    command = nil
    args = []
    request = MySqliteRequest.new
    splited_command = sql.split(" ")
    
    0.upto splited_command.length - 1 do |arg|
        # p splited_command[arg]
        if valid_actions.include?(splited_command[arg].upcase())
            if (command != nil) 
                if command != "JOIN"
                    args = args.join(" ").split(", ")
                end
                process_action(command, args, request)
                command = nil
                args = []
            end
            command = splited_command[arg].downcase()
        else
            args << splited_command[arg]
        end
    end
    # p args[-1, 1]
    if args[-1].end_with?(";")
        args[-1] = args[-1].chomp(";")
        process_action(command, args, request)
        request.run
    else
        p "Finish your request with ;"
    end
end

def run
    puts "MySQLite version 0.2 2021-feb-jan"
    while command = readline_with_hist_management
        if command == "quit"
            break
        else
            execute_request(command)
        end
    end
end

run()

