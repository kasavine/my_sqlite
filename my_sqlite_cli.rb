require 'readline'
require_relative "my_sqlite_request"


=begin
    
SELECT column1, column2
FROM table
[WHERE expr]
[ORDER how column]

SELECT columns
FROM tab1
JOIN tab2
ON col1=co2 -->columns which are in both tables
WHERE expr

INSERT table
VALUES hash ??

UPDATE table
SET column_name=new_value [, ...] 
WHERE expression ??????? - looks like it shoul only update with where

DELETE FROM table-name 
[WHERE expr]

=end

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
    end

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