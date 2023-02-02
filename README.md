## MY SQLITE

This is a program that filters data from a database using a custom class, MySQLiteRequest, which behaves like a real SQLite database (almost).

#### Usage
-  Clone the repository to your local machine: - `git clone https://github.com/kasavine/sqlite.git`
-  Change directory: `cd sqlite`
-  Run rb cli: `ruby my_sqlite_cli.rb`

#### Features
* Filters data from a database using a custom class
* Mimics the behavior of a real SQLite database
* Easy to use Command Line Interface (CLI)

#### Custom Class MySQLiteRequest
This class is used to filter data from the database. It has various methods to perform operations like SELECT, FROM, WHERE, JOIN, ORDER, INSERT, UPDATE, DELETE, just like in a real SQLite database. 

* SELECT options
  * `our-awesome-cli> SELECT lastname FROM db.csv;    [JOIN user_id=id]`
  * `our-awesome-cli> SELECT lastname, firstname FROM db.csv WHERE lastname=Laura;`
  * `our-awesome-cli> SELECT lastname, age FROM db.csv ORDER age ASC;`
  * `our-awesome-cli> SELECT * FROM tb.csv JOIN tb_join.csv ON col=col_join;`
* INSERT options
  * `our-awesome-cli> INSERT db.csv VALUES lastname=Aaaa firstname=Bbbb age=11 state=AA;`
* UPDATE options
  * `our-awesome-cli> UPDATE db.csv SET firstname=UPDATED WHERE firstname=Grey;`
  * `our-awesome-cli> UPDATE db.csv SET firstname=UPDATED; (will update every record in a table)`
* DELETE options
  * `our-awesome-cli> DELETE FROM db.csv WHERE lastname=Jamie;` 
  * `our-awesome-cli> DELETE FROM db.csv; (will delete every record in a table)`
* To quit CLI
  * `our-awesome-cli> quit`

**run()** returns instance of my_sqlite_request, building request progressively

```
request = MySqliteRequest.new
request = request.from('table_name')
request = request.select('column')
request = request.where('column', 'value')
request.run

OR

MySqliteRequest('table_name').select('column').where('column', 'value').run
```
### schema-plan
https://drive.google.com/file/d/1bH4a-3Rs9eeqjek0W94MfeFeSb4EZg_q/view?usp=sharing
