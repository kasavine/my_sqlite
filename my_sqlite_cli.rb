require 'readline'
require_relative "my_sqlite_request"


=begin
   
    0       1        2      
1   SELECT column1, column2
    0      1
2   FROM table
    0       1
3   [WHERE expr]
    0        1   2
4   [ORDER how column]

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

legal_start_points = ["SELECT", "UPDATE", "INSERT", "DELETE"]



def readline_with_hist_management
    line = Readline.readline('> ', true)
    return nil if line.nil?
    if line =~ /^\s*$/ or Readline::HISTORY.to_a[-2] == line
        Readline::HISTORY.pop
    end
    line.split(" ")
end

command = ""
table_name = ""
table_join = ""
columns = []
order = ""
expression = ""

# Debug
while line = readline_with_hist_management
    # p line
    # p Readline::HISTORY.to_a

    if line[0] == "SELECT"
        p "I am select"
        if line[1] == nil
            p "THere is no chosen columns, you have to provide them."
        end
        1.upto line.length - 1 do |arg|
            columns << line[arg]
        end
    end
    p columns

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