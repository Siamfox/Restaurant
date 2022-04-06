LOCAL loForm, loWsh, lcWallpaper

loWsh = CreateObject("wscript.shell")  
lcWallpaper = loWsh.RegRead("HKCU\Control Panel\Desktop\Wallpaper")
loWsh = Null

loForm = CREATEOBJECT("Form")
loForm.WIDTH = 800
loForm.HEIGHT = 600
loForm.AUTOCENTER = .T.
loForm.PICTURE = lcWallpaper
loForm.SHOW(1)
loForm = Null

RETURN 