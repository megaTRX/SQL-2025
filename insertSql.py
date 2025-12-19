import pymysql
connect = pymysql.connect(host='127.0.0.1', user='root', password='1234', db='market_db', charset='utf8')
cursor = connect.cursor()
count = 0
while (True) :
  d1 = input("멤버 ID (Q:종료)==> ")
  if d1 == "q" or d1 == "Q" :
    break
  d2 = input("멤버 이름 ==> ")
  d3 = input("멤버수 ==> ")
  d4 = input("주소 ==> ")
  d5 = input("폰넘버1 ==> ")
  d6 = input("폰넘버2 ==> ")
  d7 = input("키 ==> ")
  d8 = input("데뷔일자 ==> ")
  sql = "INSERT INTO member VALUES(%s, %s, %s, %s, %s, %s, %s, %s)" # 자리만 화보
  d = (d1, d2, d3, d4, d5, d6, d7, d8)

                     # 큰따옴표, 작은따옴표, 쉼표 ... 다른 방법은?
  cursor.execute(sql, d)
  count += 1
  print('--------------')
connect.commit() # insert는 커밋 해줘야 실제 저장
connect.close()
print(count, ' 건 등록 완료')