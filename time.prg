STORE DATETIME( ) TO gtDtime  && Creates a Datetime type memory variable
CLEAR
? "gtDtime is type: "
?? TYPE('gtDtime')  && Displays T, Datetime type value
gtDtime = TTOC(gtDtime)     &&  Converts gtDtime to a character value
? "gtDtime is now type: "
?? TYPE('gtDtime')  && Displays C, character type value
