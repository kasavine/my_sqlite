require 'csv'
require_relative "data_operations"

class MySqliteRequest

    def initialize
        @db = nil
        @request = nil
    end

    def from(db)
        @db = db
    end

    def select(columns)
        @request = 'select'
        @columns = columns
        return self
    end

    def run_select
        if @request == 'select'
        end
    end
end