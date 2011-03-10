import sqlite3, os, sys

dbname = 'maple.sqlite'
tree_tuples = []

testexist = open(dbname, 'w')
testexist.close()

db = sqlite3.connect(dbname)
db_c = db.cursor()

db_c.execute(r'CREATE TABLE "maple_db"' +
r'("rank" INTEGER, "name" TEXT, "world" TEXT, ' +
r'"job" TEXT, "level" INTEGER)')
db.commit()

def db_count(cat):
	return "SELECT %s, job, count(*) FROM maple_db GROUP BY %s, job ORDER BY count(*), job DESC" % (cat, cat)

#SELECT level, job, count(*) FROM maple_db GROUP BY level, job ORDER BY count(*), job DESC

f = open(sys.argv[1], 'r')



for line in f:
	words = line.split()
	tree_tuples.append((int(words[0]),words[1],words[2],words[3],int(words[4])))

#print tree_tuples

f.close()

db_c.executemany("insert into maple_db values (?, ?, ?, ?, ?)", tree_tuples)

db.commit()

db_c.execute(db_count("job"))
#db_c.execute(r'SELECT world, job FROM maple_db')

with open('dump.sql','w') as l:
  for line in db.iterdump():
    l.write('%s\n' % line)


print db_c.fetchall()

