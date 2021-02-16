require 'csv'
require_relative "data_operations"

class MySqliteRequest

    # def initialize
    #     @table_name = nil
    #     @request = nil
    # end

    # From - implements a from method which must be present on each request. 
    # From will take a parameter and it will be the name of the table. 
    # (technically a table_name is also a filename (.csv))
    def from(table_name)
        @table_name = table_name
        return self
    end

    # Select - implements a select method which will take one argument a string OR an array of string. 
    # It will continue to build the request. 
    # During the run() you will collect on the result only the columns sent as parameters to select :-)
    def select(columns)
        @request = 'select'
        @columns = columns
        return self
    end

    # Where - implements a where method which will take 2 arguments: column_name and value. 
    # It will continue to build the request. 
    # During the run() you will filter the result which match the value.
    # def where(column, value)
    #     @where = {column: column, value: value}
    #     return self
    # end

    # Join - implements a join method which will load another filename_db 
    # and will join both database on a on column.
    # def join
    # end

    # Order - implements an order method which will received two parameters, 
    # order (:asc or :desc) and column_name. 
    # It will sort depending on the order base on the column_name.
    # def order(order, column_name)
    #     @order_request = {order: order, column_name: column_name}
    #     return self
    # end

    # Insert - implements a method insert which will receive a table name (filename). 
    # It will continue to build the request.
    # def insert(table_name)
    #     @request = 'insert'
    #     return self
    # end

    # Values - implements a method values which will receive data. 
    # (a hash of data on format (key => value)). 
    # It will continue to build the request. 
    # During the run() you do the insert.
    # def values(data)
    #     if @request != 'insert'
    #         p 'ERROR: VALUES works in pair with INSERT'
    #     else
    #         @data = data
    #     end
    #     return self
    # end

    # Update - implements a method update which will receive a table name (filename). 
    # It will continue to build the request. 
    # An update request might be associated with a where request.
    # def update(table_name)
    #     @request = 'update'
    #     return self
    # end

    # Set - implements a method set which will receive data (a hash of data on format (key => value)). 
    # It will perform the update of attributes on all matching row. 
    # An update request might be associated with a where request.
    # def set(data)
    #     if @request != 'update'
    #         p 'ERROR: SET works in pair with UPDATE'
    #     else 
    #         @data = data
    #     end
    #     return self
    # end

    # Delete - implements a delete method. 
    # It set the request to delete on all matching row. 
    # It will continue to build the request. 
    # An delete request might be associated with a where request.
    # def delete
    #     @request = 'delete'
    #     return self
    # end

    # Run - implements a run method and it will execute the request.
    def run
        if @request == 'select'
            p "Inside of select"
        end
        # if @request == 'insert'
        #     p "Inside of insert"
        # end
        # if @request == 'update'
        #     p "Inside of update"
        # end
        # if @request == 'delete'
        #     p "Inside of delete"
        # end
    end
end

# MySqliteRequest.new.insert('db.csv').values({"name"=>"A", "birth_state"=>"CA", "age"=>"60"}).run
# MySqliteRequest.new.insert('db.csv').set({"name"=>"A", "birth_state"=>"CA", "age"=>"60"}).run
# MySqliteRequest.new.update('db.csv').set({"name"=>"A", "birth_state"=>"CA", "age"=>"60"}).run
# MySqliteRequest.new.from('db.csv').select(['name', 'age']).run
# MySqliteRequest.new.delete.run
