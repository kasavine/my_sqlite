require_relative "my_sqlite_request"
require_relative "data_operations"

class TestOperations
    def test_order
        parsed_csv = load_csv_hash()
        order(parsed_csv, "asc", "age")
        write_to_file(parsed_csv)
    end

    def test_get_columns
        parsed_csv = load_csv_hash()
        columns = ["name", "age"]
        p get_columns(parsed_csv, columns)
    end

    def test_insert
        parsed_csv = load_csv_hash()
        new_hash = {"name" => "iva", "birth_state" => "CA", "age" => 90}
        p insert_op(parsed_csv, new_hash)
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
        p update_op(parsed_csv, criteria_hash, update_hash)
        write_to_file(result)
    end

    def test_where
        parsed_csv = load_csv_hash()
        criteria_hash = {"birth_state" => "CA"}
        p where_op(parsed_csv, criteria_hash)
    end

    def test_delete
        parsed_csv = load_csv_hash()
        criteria_hash = {"birth_state" => "NJ"}
        p delete_op(parsed_csv, criteria_hash)
    end
end

class TestRequests
    def test_select
        p "FIRST - name and age"
        p "- - - - - - - - - -"
        MySqliteRequest.new.from('db.csv').select(['name', 'age']).run
        p "- - - - - - - - - -"
        p "SECOND - only name"
        p "- - - - - - - - - -"
        MySqliteRequest.new.from('db.csv').select(['name']).run
        p "- - - - - - - - - -"
        p "THIRD - only birth_state"
        p "- - - - - - - - - -"
        MySqliteRequest.new.from('db.csv').select(['birth_state']).run
    end

    def test_select_where
        p "FIRST - name, where --> birth_state == CA"
        p "- - - - - - - - - -"
        MySqliteRequest.new.from('db.csv').select(['name']).where('birth_state', 'CA').run
        p "SECOND - name & age, where --> age == 20"
        p "- - - - - - - - - -"
        MySqliteRequest.new.from('db.csv').select(['name', 'birth_state']).where('age', '20').run
    end

    def test_select_order
        p "FIRST - show age in asc order"
        p "- - - - - - - - - -"
        MySqliteRequest.new.from('db.csv').select(['age']).order('asc', 'age').run
        p "SECOND - show name in desc order"
        p "- - - - - - - - - -"
        MySqliteRequest.new.from('db.csv').select(['name']).order('desc', 'name').run
    end

    def test_select_where_order
        p "FIRST - show name & age,  where --> birth_state == NY, age in asc order"
        p "- - - - - - - - - -"
        MySqliteRequest.new.from('db.csv').select(['name', 'age']).where('birth_state', 'NY').order('asc', 'age').run 
        p "SECOND - show name & age, where --> birth_state == NY, age in descw order"
        p "- - - - - - - - - -"
        MySqliteRequest.new.from('db.csv').select(['name', 'age']).where('birth_state', 'NY').order('desc', 'age').run
    end

    def test_insert

        # how to handle case when csv file is empty - is there have to be at least one record with keys ???

        MySqliteRequest.new.insert('db.csv').values({"name"=>"A", "birth_state"=>"CA", "age"=>"10"}).run
        MySqliteRequest.new.insert('db.csv').values({"name"=>"G", "birth_state"=>"CA", "age"=>"60"}).run
        MySqliteRequest.new.insert('db.csv').values({"name"=>"D", "birth_state"=>"NY", "age"=>"30"}).run
        MySqliteRequest.new.insert('db.csv').values({"name"=>"E", "birth_state"=>"NY", "age"=>"20"}).run
        MySqliteRequest.new.insert('db.csv').values({"name"=>"C", "birth_state"=>"TX", "age"=>"50"}).run
        MySqliteRequest.new.insert('db.csv').values({"name"=>"B", "birth_state"=>"WA", "age"=>"40"}).run
        MySqliteRequest.new.insert('db.csv').values({"name"=>"I", "birth_state"=>"WA", "age"=>"90"}).run

        # how to handle this case ???
        MySqliteRequest.new.insert('db.csv').values({"name"=>"I", "age"=>"90"}).run
    end

    def test_insert_without_values
        # nothing - should be error ???
        MySqliteRequest.new.insert('db.csv').run
    end

    def test_insert_wrong_values
        # nothing - should be error ???
        MySqliteRequest.new.insert('db.csv').values({"family" => "big"}).run
    end

    def test_update
        # shoud this case exist ??? - it will update every row in a table with new data 
        MySqliteRequest.new.update('db.csv').set({"age"=>"22"}).run

        MySqliteRequest.new.update('db.csv').set({"age"=>"33"}).where('name', 'Andre').run
        MySqliteRequest.new.update('db.csv').set({"age"=>"44"}).where('name', 'B').run
        MySqliteRequest.new.update('db.csv').set({"age"=>"55"}).where('name', 'C').run
        MySqliteRequest.new.update('db.csv').set({"age"=>"66"}).where('name', 'G').run
    end

    def test_update_without_set
        # error - my_merge doesn't work, should be handled
        MySqliteRequest.new.update('db.csv').run
    end

    def test_delete
        MySqliteRequest.new.delete('db.csv').where('name', 'C').run
        # why it is deleting "a" - in the table there is only "A" -  WHY ??????
        MySqliteRequest.new.delete('db.csv').where('name', 'a').run
    end

    def test_delete_everything
        # delete everything - should it work like that ???
        MySqliteRequest.new.delete('db.csv').run
    end
end

request = TestRequests.new
# request.test_insert
request.test_insert_wrong_values