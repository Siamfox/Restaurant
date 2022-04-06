**--abregaveta2

***PARAMETERS xgaveta

***???+ALLTRIM(xgaveta)


**--Lista de printer  para abrie gaveta
**--

*!*	Marca	Modelo	Codigos de apertura
*!*	 Axionhm	 A715,A756,A794	 27,112,0,48,251
*!*	 Bixolon	 SRP-275	 27,112,48,55,121
*!*	 Epson	 All	 27,121,48,55,121
*!*	 Epson	 M51PD	 27,112,48,55,121
*!*	 Epson	 TM-T60	 27,112,32,25
*!*	 Epson	 TM-L60II	 27,70,0,50,50
*!*	 Epson	 TM-T70	 27,112,48,55,121
*!*	 Epson	 T88iii TM-U200D	 27,112,0,25,250
*!*	 Epson	 T88iiiP TM-U200D	 27,112,0,64,240
*!*	 Epson	 TM-88IV	 27,112,48,55,121
*!*	 Epson	 TM-88V	 27,112,48,55,121
*!*	 Epson	 M188D	 27,112,48,55,121
*!*	 Epson	 M192C	 27,112,48,55,121
*!*	 Epson	 TM-U200	 27,112,0,25,250
*!*	 Epson	 TM-U200B	 27,112,48,25,250
*!*	 Epson	 TM-U200D	 27,112,0,64,240
*!*	 Epson	 TM-U210PD, TM-U210-D	 27,112,0,25,250
*!*	 Epson	 TM-U220A, TM-U220PD	 27,112,0,25,250
*!*	 Epson	 TM-U295	 27,112,48,55,121
*!*	 Epson	 ADP 300	 27,112,0,25,250
*!*	 Epson	 TM-300D	 27,112,0,25,250
*!*	 Epson	 TM-U950P	 27,112,0,25,250
*!*	 Epson	 TM-U300PD	 27,112,0,25,250
*!*	 Epson	 TM-U325D	 27,112,0,25,250
*!*	 Epson	 TM-U375	 27,112,0,25,250
*!*	 Epson	 M665A	 27,112,0,50,250
*!*	 Epson	 TM-T883P	 27,112,0,50,250
*!*	 Epson	 TM-U950P	 27,112,0,50,250
*!*	 Epson	 TM-H500II	 27,113,0,25,250
*!*	 Epson	 TM-H6000	 27,112,48,55,121
*!*	 IBM	 4610	 7
*!*	 IBM	 4610	 27,112,0,50,250
*!*	 Ithaca	 PcOS 51	 27,112,0,25,250
*!*	 Ithaca	 PcOS 52	 27,112,0,25,250
*!*	 Ithaca	 PcOSjet	 27,112,0,25,250
*!*	 Ithaca	 80 PLUS	 27,120,1
*!*	 Ithaca	 SERIES 90	 27,120,1
*!*	 Ithaca	 150	 27,120,1
*!*	 Ithaca	 POSjet 1000	 27,120,1
*!*	 NCR	 7167	 27,120,1
*!*	 Oliveti	 PRT-100	 27,112,0,25,250
*!*	 Pos-X	 XR-200	 27,112,0,25,250
*!*	 Pos-X	 XR-500	 27,112,0,25,250
*!*	 Posiflex	CR 4200	 27,112,80,25,250
*!*	 Posiflex	 AURA 5600	 27,112,0,25,250
*!*	 Posiflex	 PP6000/7000	 27,112,0,25,250
*!*	 Samsung	 SRP 131	 27,112,0,48,50
*!*	 Samsung	 SRP 270	 27,112,0,25,250
*!*	 Samsung	 SRP 270A	 27,112,0,64,240
*!*	 Samsung	 SRP 270	 27,112,48,55,121
*!*	 Samsung	 SRP 350	 27,110,0,25,250
*!*	 Star	 All	 27,7,11,55,7
*!*	 Star	 TSP 100	 7
*!*	 Star	 SP212	 27,7,11,55,7
*!*	 Star	 TSP200	 27,7,11,55,7
*!*	 Star	 SP500	 27,122,49,7
*!*	 Star	 TSP-600	 27,7,10,50,7
*!*	 Star	 TSP-700	 27,07,11,55,07
*!*	 Star	 SP2000	 27,122,49,7
*!*	 Tec	 RKP300	 27,112,0,100,250
*!*	 Tec	 TRST-53	 27,112,0,100,250
*!*	 Toshiba	 SX2100	 27,112,32,55,255
*!*	 Toshiba Tec	 DRJST-51	 27,112,0,100,250
*!*	 Unisys	 EF4272	 27,112,0,100,250
*!*	 Wasp	 WTP-100	 27,112,49,48,48
*!*	 Wastrex	 4200	 7



**--Impresora Bixolo 270
*Samsung	 SRP 270	 27,112,0,25,250
*Samsung	 SRP 270A	 27,112,0,64,240
*Samsung	 SRP 270	 27,112,48,55,121
**<1B><70><30><37><79> && en hexadecimal

**--Abrir por Puerto Asignado como Gaveta desde Panel de Control
**--Dirigir segun Nombre del Printer/Gaveta/	

**--Nazacar	
SET PRINTER TO NAME 'EPSON TM-U220'

???CHR(27)+CHR(112)+CHR(0)+CHR(25)+CHR(250)
*!*	???CHR(27)+CHR(112)+CHR(0)+CHR(64)+CHR(240)
*!*	???CHR(27)+CHR(112)+CHR(48)+CHR(55)+CHR(121)


*!*	*Código para Abrir la Caja de Dinero.
*!*	??? CHR(27)+'p'+CHR(0)+CHR(40)+CHR(250)        
*!*	??? CHR(7)

SET PRINTER TO 