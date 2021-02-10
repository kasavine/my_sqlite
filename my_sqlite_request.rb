require 'csv'

def load_csv_hash
    list_of_hashes = CSV.open('db.csv', headers: true).map(&:to_h)
    return list_of_hashes
end

def get_columns(list_of_hashes, list_of_columns)
    result = []
    list_of_hashes.each do |hash|
        new_hash = {}
        list_of_columns.each do |column|
            new_hash[column] = hash[column]
        end
        result << new_hash
    end
     return result
end

def order(list_of_hashes, order_type, column)
    0.upto list_of_hashes.length - 1 do |i|
        i.upto list_of_hashes.length - 1 do |j|
            line_i = list_of_hashes[i] # "name" => "iva", "age" => 5, "gender" => "F"}
            line_j = list_of_hashes[j] # {"name" => "tor", "age" => 2, "gender" => "M"}

            val_i = line_i[column] #  "age" => 5
            val_j = line_j[column] #  "age" => 2

            if order_type == "asc"
                if val_i > val_j
                    temp = list_of_hashes[i]
                    list_of_hashes[i] = list_of_hashes[j]
                    list_of_hashes[j] = temp
                end
            else
                if val_i < val_j
                    temp = list_of_hashes[i]
                    list_of_hashes[i] = list_of_hashes[j]
                    list_of_hashes[j] = temp
                end
            end
        end
    end
    return list_of_hashes
end

# {"name" => "iva", "age" => 5, "gender" => "F"}
def insert(list_of_hashes, new_hash)
    result = []
    list_of_hashes.each do |row|
        result.push(row)
    end
    result.push(new_hash)
    return result
end


# helper for update
def is_criteria_satisfied (line_from_list, criteria_hash)
    criteria_hash.each do |key, value|
        if value != line_from_list[key]
            return false
        end 
    end
    return true
end

# helper for update
def my_merge(line_from_list, update_hash)
    update_hash.each do |key, value|
        line_from_list[key] = value
    end
    return line_from_list
end

def update(list_of_hashes, criteria_hash, update_hash)
    result = []
    list_of_hashes.each do |row|
        if is_criteria_satisfied(row, criteria_hash)
            updated_row = my_merge(row, update_hash)
            result << updated_row
        else
            result << row
        end
    end
    return result
end

