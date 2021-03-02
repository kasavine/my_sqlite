# sqlite

# schema-plan
https://drive.google.com/file/d/1bH4a-3Rs9eeqjek0W94MfeFeSb4EZg_q/view?usp=sharing

# to run CLI
    ruby my_sqlite_cli.rb

our-awesome-cli> SELECT lastname FROM db.csv    [JOIN user_id=id]
our-awesome-cli> SELECT lastname, firstname FROM db.csv WHERE lastname=Laura 
our-awesome-cli> SELECT lastname, age FROM db.csv ORDER age ASC

our-awesome-cli> SELECT * FROM tb.csv JOIN tb_join.csv ON col=col_join


our-awesome-cli> INSERT db.csv VALUES lastname=Aaaa firstname=Bbbb age=11 state=AA
split on commas

our-awesome-cli> UPDATE db.csv SET firstname=UPDATED WHERE firstname=Grey
check for WHERE ...

our-awesome-cli> DELETE FROM db.csv WHERE lastname=Jamie 
our-awesome-cli> DELETE FROM db.csv 
check for WHERE ...


# to close CLI
our-awesome-cli> quit


## db.csv
name,birth_state,age
Andre,NJ,30
Nick,CA,10
Adam,WA,20
Mel,NY,50
Turtle,NY,40
Den,CA,10
Maria,TX,60
Carlos,NY,30
Stephany,OR,20

## tb.csv
id_student,name,lastname
3,Slava,Kov
1,Den,Cho
2,Iva,Sak

## tb_join.csv
id,age,gender
2,30,F
1,20,M
3,40,M