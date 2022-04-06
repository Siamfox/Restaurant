Declare Long FindWindow  In WIN32API String, String
Declare Long SetWindowPos  In WIN32API Integer,Integer,Integer,Integer,Integer,Integer,Integer
Declare Long ShowWindow  In WIN32API Long, Long

HWnd = FindWindow( .Null. , "On-Screen Keyboard" )

If HWnd = 0

 	*run /n osk

	RUN osk
   
    HWnd = FindWindow( .Null. , "On-Screen Keyboard")

    SetWindowPos( HWnd , -1 , 1, 0, 0 , 300 , 0 )
ELSE

    ShowWindow( HWnd , 9 )
    SetWindowPos( HWnd , -1 , 1, Sysmetric(22)-300 , Sysmetric(21) , 300 , 0 )
Endif