require 'csv'
require_relative "data_operations"

class MySqliteRequest
    def initialize
        @table_name = nil
        @request = nil
    end

    def from(table_name)
        if table_name == nil
            puts "Provide existing table. Ex.: db.csv"
        else
            @table_name = table_name
        end
        return self
    end
    
    def select(columns)
        if columns == nil
            puts "Select column(s)."
        else
            @request = 'select'
            @columns = columns
        end
        return self
    end

    def where(column, value)
        @where = {column: column, value: value}
        return self
    end

    def join(column_on_db_a, filename_db_b, column_on_db_b)
        @join = {column_a: column_on_db_a, column_b: column_on_db_b}
        @table_name_join = filename_db_b
        return self
    end

    def order(order, column_name)
        @order_request = {order: order, column_name: column_name}
        return self
    end

    def insert(table_name)
        @request = 'insert'
        @table_name = table_name
        return self
    end

    def values(data)
        @data = data
        return self
    end

    def update(table_name)
        @request = 'update'
        @table_name = table_name
        return self
    end

    def set(data)
        @data = data
        return self
    end

    def delete
        @request = 'delete'
        return self
    end

    def run_join
        parsed_csv_a = load_csv_hash(@table_name)
        parsed_csv_b = load_csv_hash(@table_name_join)
        parsed_csv_b.each do |row|
            criteria = {@join[:column_a] => row[@join[:column_b]]}
            row.delete(@join[:column_b]) 
            update_op(parsed_csv_a, criteria, row) 
        end
        # p parsed_csv_a
        return parsed_csv_a
    end

    def print_selection(result)
        if !result
            return
        end
        if result.length == 0
            puts "There is no result for this request."
        else
            puts result.first.keys.join(' | ')
            len = result.first.keys.join(' | ').length
            puts "-" * len
            result.each do |line|
                puts line.values.join(' | ')
            end
            puts "-" * len
        end
    end

    # run executes the request.
    def run
        if @table_name != nil
            parsed_csv = load_csv_hash(@table_name)
        else
            puts "Valid request contains table"
            return
        end
        if @request == 'select'
            if @join != nil
                parsed_csv = run_join
            end
            if @order_request != nil
                parsed_csv = order_op(parsed_csv, @order_request[:order], @order_request[:column_name])
            end
            if @where != nil
                parsed_csv = where_op(parsed_csv, {@where[:column]=> @where[:value]})
            end
            if @columns != nil && @table_name != nil
                result = get_columns(parsed_csv, @columns)
                print_selection(result)
            else
                puts "Provide columns to SELECT"
                return
            end
        end

        if @request == 'insert'
            if @data != nil
                parsed_csv = insert_op(parsed_csv, @data)
            end
            write_to_file(parsed_csv, @table_name)
        end

        if @request == 'update'
            if @where != nil
                @where = {@where[:column] => @where[:value]}
            end
            parsed_csv = update_op(parsed_csv, @where, @data)
            write_to_file(parsed_csv, @table_name)
        end

        if @request == 'delete'
            if @where != nil
                @where = {@where[:column]=> @where[:value]}
            end
            parsed_csv = delete_op(parsed_csv, @where)
            write_to_file(parsed_csv, @table_name)
        end

        @request = nil
        @where = nil
        @table_name = nil
        @data = nil
        @join = nil
    end
end