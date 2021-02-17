require 'readline'
require_relative "my_sqlite_request"

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


#  ["SELECT", "ISERT", "UPDATE", "DELETE"]
command = ""
table_name = ""
columns = []

while buf = Readline.readline("> ", true)

    print("-> ", buf, "\n")
    
    command = buf.split(" ")[0]
    if command == "UPDATE" || command == "INSERT" || command == "DELETE"
        table_name = buf.split(" ")[1]
        if table_name == nil
            p "ERROR - provide table name to update, or to insert, or to delete"
        end
        p table_name
        # if command == "SET"
        #     p "set work with UPDATE"
        # end
        # p command

    elsif command == "SELECT"
        columns = buf.split(" ")[1]   # how to check all list of names???
        if columns == nil
            p "ERROR - provide columns from the table"
        end
        p columns
    else
        p "provide valid starting point - SELECT, INSERT, UPDATE, DELETE"
    end

end
