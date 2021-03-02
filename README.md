## sqlite

## schema-plan
https://drive.google.com/file/d/1bH4a-3Rs9eeqjek0W94MfeFeSb4EZg_q/view?usp=sharing

## to run CLI
    ruby my_sqlite_cli.rb

- our-awesome-cli> SELECT lastname FROM db.csv    [JOIN user_id=id]
- our-awesome-cli> SELECT lastname, firstname FROM db.csv WHERE lastname=Laura 
- our-awesome-cli> SELECT lastname, age FROM db.csv ORDER age ASC

- our-awesome-cli> SELECT * FROM tb.csv JOIN tb_join.csv ON col=col_join

- our-awesome-cli> INSERT db.csv VALUES lastname=Aaaa firstname=Bbbb age=11 state=AA

- our-awesome-cli> UPDATE db.csv SET firstname=UPDATED WHERE firstname=Grey
- our-awesome-cli> UPDATE db.csv SET firstname=UPDATED (will update every record in a table)

- our-awesome-cli> DELETE FROM db.csv WHERE lastname=Jamie 
- our-awesome-cli> DELETE FROM db.csv (will delete every record in a table)

## to quit CLI
our-awesome-cli> quit