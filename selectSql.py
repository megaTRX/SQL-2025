import pymysql
connect = pymysql.connect(host='127.0.0.1', user='root', password='1234', db='market_db', charset='utf8')
cursor = connect.cursor()
cursor.execute("SELECT * FROM member")
print("사용자ID 사용자이름 사용자넘버 주소 폰넘버1 폰넘버2 키 데뷔연도")
print("---------------------------------------------------------")
while (True) :
   row = cursor.fetchone() # select 해 온 각 행(튜플)
   if row == None :
       break
   print(" %-10s %-10s %d %-10s %-10s %-10s %d %-20s" % (row[0], row[1], row[2], row[3], row[4], row[5], row[6], row[7]))
connect.close()