# require_relative "my_sqlite_request"
require_relative "data_operations"
def test_order
    parsed_csv = load_csv_hash()
    order(parsed_csv, "asc", "age")
    p parsed_csv
end

def test_get_columns
    parsed_csv = load_csv_hash()
    columns = ["name", "age"]
    p get_columns(parsed_csv, columns)
end

def test_insert
    parsed_csv = load_csv_hash()
    new_hash = {"name" => "iva", "birth_state" => "CA", "age" => 90}
    result = insert(parsed_csv, new_hash)
    p result
end

def test_is_criteria
    criteria_hash = {"name" => "iva", "age" => 5}
    line_from_list = {"name" => "ivan", "age" => 5, "gender" => "M"}
    p is_criteria_satisfied(line_from_list, criteria_hash)
end

def test_update
    parsed_csv = load_csv_hash()
    criteria_hash = {"name" => "Andre"}
    update_hash = {"name" => "IVAN", "birth_state" => "NY"}
    p update(parsed_csv, criteria_hash, update_hash)
end

def test_where
    parsed_csv = load_csv_hash()
    criteria_hash = {"birth_state" => "CA"}
    p where(parsed_csv, criteria_hash)
end

def test_delete
    parsed_csv = load_csv_hash()
    criteria_hash = {"birth_state" => "CA"}
    p delete(parsed_csv, criteria_hash)
end

test_delete