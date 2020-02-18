

    0 rem ---------------------------------
    1 rem cityxen 128 subscriber special
    2 rem binary counter from 0 to 128!
    3 rem thank you!
    9 rem ---------------------------------
   10 print"{clr}":poke53280,0:poke53281,0
   15 ti$="000000":wait162,64
   16 ti$="000000":wait162,64
   17 ti$="000000":wait162,64
   20 fori=0to128
   25 ti$="000000"
   30 b$=""
   40 ifiand128thenb$=b$+"1":goto50
   45 b$=b$+"0"
   50 ifiand 64thenb$=b$+"1":goto60
   55 b$=b$+"0"
   60 ifiand 32thenb$=b$+"1":goto70
   65 b$=b$+"0"
   70 ifiand 16thenb$=b$+"1":goto80
   75 b$=b$+"0"
   80 ifiand  8thenb$=b$+"1":goto90
   85 b$=b$+"0"
   90 ifiand  4thenb$=b$+"1":goto100
   95 b$=b$+"0"
  100 ifiand  2thenb$=b$+"1":goto110
  105 b$=b$+"0"
  110 ifiand  1thenb$=b$+"1":goto120
  115 b$=b$+"0"
  120 print"{home}{down}{rght}"b$;:print" "i" "
  125 wait 162,64
  130 next

