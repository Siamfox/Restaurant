DEFINE WINDOW wBrowse FROM 1,1 TO 24,40 ;
CLOSE ;
GROW ;
COLOR SCHEME 10
CLOSE DATABASES
OPEN DATABASE (HOME(2) + 'data\testdata')
USE customer  && Open customer table
BROWSE WINDOW wBrowse ;
FIELDS phone :H = 'Phone Number:' , ;
company :H = 'Company:' ;
TIMEOUT 10
RELEASE WINDOW wBrowse
