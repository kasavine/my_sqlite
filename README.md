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

our-awesome-cli> UPDATE db.csv SET firstname=UPDATED WHERE firstname=Grey

our-awesome-cli> DELETE FROM db.csv WHERE lastname=Jamie 

our-awesome-cli> DELETE FROM db.csv 

# to quit CLI
our-awesome-cli> quit

## db.csv
id,name,birth_state,age

1,Andre,NJ,30

2,Nick,CA,10

3,Adam,WA,20

4,Mel,NY,50

5,Turtle,NY,40

6,Den,CA,10

7,Maria,TX,60

8,Carlos,NY,30

9,Stephany,OR,20

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