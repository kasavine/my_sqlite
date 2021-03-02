require 'csv'

# list_of_hashes = [{"name" => "tor", "age" => 2, "gender" => "M"}, {...}, {...}]
def load_csv_hash(db_name)
    if(!File.exist?(db_name))
        puts 'File does not exist'
        return
    else
        list_of_hashes = CSV.open(db_name, headers: true).map(&:to_hash)
        return list_of_hashes
    end
end

# list_of_hashes = [{"name" => "tor", "age" => 2, "gender" => "M"}, {...}, {...}]
# result ->> name,birth_state,age
#           Andre,CA,60
def write_to_file(list_of_hashes, db_name)
    CSV.open(db_name, "w", :headers => true) do |csv|
        if list_of_hashes.length == 0
            return
        end 
        csv << list_of_hashes[0].keys # how to fix this???
        list_of_hashes.each do |hash|
            csv << CSV::Row.new(hash.keys, hash.values)
        end
    end
end

# list_of_hashes = [{"name" => "tor", "age" => 2, "gender" => "M"}, {...}, {...}]
# list_of_columns = ["name", "age"] 
def get_columns(list_of_hashes, list_of_columns)
    if !list_of_hashes
        return
    else
        result = []
        list_of_hashes.each do |hash|
            new_hash = {}
            if list_of_columns[0] == "*"
                result << hash
            else 
                list_of_columns.each do |column|
                    new_hash[column] = hash[column]
                end
                result << new_hash
            end
        end
        return result
    end
end

# list_of_hashes = [{"name" => "tor", "age" => 2, "gender" => "M"}, {...}, {...}]
# order_type = "asc" OR "desc"
# column = "name"
def order_op(list_of_hashes, order_type, column)
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
            elsif order_type == "desc"
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

# list_of_hashes = [{"name" => "tor", "age" => 2, "gender" => "M"}, {...}, {...}]
# new_hash = {"name" => "iva", "age" => 5, "gender" => "F"}
def insert_op(list_of_hashes, new_hash)
    result = []
    list_of_hashes.each do |row|
        result.push(row)
    end
    result.push(new_hash)
    return result
end

# list_of_hashes = [{"name" => "tor", "age" => 2, "gender" => "M"}, {...}, {...}]
# criteria_hash = {"name" => "tor", "age" => 2}
# true or false
def is_criteria_satisfied (line_from_list, criteria_hash)
    if criteria_hash == nil
        return true
    end
    criteria_hash.each do |key, value|
        if value != line_from_list[key]
            return false
        end 
    end
    return true
end

# list_of_hashes = [{"name" => "tor", "age" => 2, "gender" => "M"}, {...}, {...}]
# update_hash = {"name" => "tor", "age" => 555}
def my_merge(line_from_list, update_hash)
    update_hash.each do |key, value|
        line_from_list[key] = value
    end
    return line_from_list
end

# list_of_hashes = [{"name" => "tor", "age" => 2, "gender" => "M"}, {...}, {...}]
# criteria_hash = {"name" => "tor", "age" => 2}
# update_hash = {"name" => "tor", "age" => 555, "gender" => "M"}
def update_op(list_of_hashes, criteria_hash, update_hash)
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

# list_of_hashes = [{"name" => "Andre", "birth_state" => "CA", "age" => 60}, {...}, {...}]
# criteria_hash = {"birth_state" => "CA"}
def where_op(list_of_hashes, criteria_hash)
    result = []
    list_of_hashes.each do |row|
        if is_criteria_satisfied(row, criteria_hash)
            result << row
        end
    end
    return result
end

# list_of_hashes = [{"name" => "Andre", "birth_state" => "CA", "age" => 60}, {...}, {...}]
# criteria_hash = {"birth_state" => "CA"}
def delete_op(list_of_hashes, criteria_hash)
    result = []
    if criteria_hash != nil
        list_of_hashes.each do |row|
            if is_criteria_satisfied(row, criteria_hash)
                next
            else
                result << row
            end
        end
    end
    return result
end