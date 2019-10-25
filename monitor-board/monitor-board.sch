EESchema Schematic File Version 4
LIBS:monitor-board-cache
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L RF_Module:ESP32-WROOM-32 U?
U 1 1 5DB29ADF
P 2400 3000
F 0 "U?" H 2400 4581 50  0000 C CNN
F 1 "ESP32-WROOM-32" H 2400 4490 50  0000 C CNN
F 2 "RF_Module:ESP32-WROOM-32" H 2400 1500 50  0001 C CNN
F 3 "https://www.espressif.com/sites/default/files/documentation/esp32-wroom-32_datasheet_en.pdf" H 2100 3050 50  0001 C CNN
	1    2400 3000
	1    0    0    -1  
$EndComp
Text GLabel 1550 1800 0    50   Input ~ 0
EN
Text GLabel 3200 1800 2    50   Input ~ 0
0
$Comp
L power:GND #PWR?
U 1 1 5DB2CD36
P 2400 4600
F 0 "#PWR?" H 2400 4350 50  0001 C CNN
F 1 "GND" H 2405 4427 50  0000 C CNN
F 2 "" H 2400 4600 50  0001 C CNN
F 3 "" H 2400 4600 50  0001 C CNN
	1    2400 4600
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR?
U 1 1 5DB2D728
P 2400 1350
F 0 "#PWR?" H 2400 1200 50  0001 C CNN
F 1 "+3.3V" H 2415 1523 50  0000 C CNN
F 2 "" H 2400 1350 50  0001 C CNN
F 3 "" H 2400 1350 50  0001 C CNN
	1    2400 1350
	1    0    0    -1  
$EndComp
Wire Wire Line
	2400 1350 2400 1600
Wire Wire Line
	3000 1800 3200 1800
Wire Wire Line
	1550 1800 1800 1800
$Comp
L power:GND #PWR?
U 1 1 5DB311C1
P 9350 1300
F 0 "#PWR?" H 9350 1050 50  0001 C CNN
F 1 "GND" H 9355 1127 50  0000 C CNN
F 2 "" H 9350 1300 50  0001 C CNN
F 3 "" H 9350 1300 50  0001 C CNN
	1    9350 1300
	1    0    0    -1  
$EndComp
Wire Wire Line
	9900 1300 9350 1300
Text Label 10150 1200 2    50   ~ 0
FTDI
$Comp
L power:+3.3V #PWR?
U 1 1 5DB3269C
P 9700 1500
F 0 "#PWR?" H 9700 1350 50  0001 C CNN
F 1 "+3.3V" H 9715 1673 50  0000 C CNN
F 2 "" H 9700 1500 50  0001 C CNN
F 3 "" H 9700 1500 50  0001 C CNN
	1    9700 1500
	1    0    0    -1  
$EndComp
Wire Wire Line
	9900 1500 9700 1500
Text GLabel 9750 1600 0    50   Input ~ 0
TX_FTDI
Text GLabel 9400 1700 0    50   Input ~ 0
RX_FTDI
Wire Wire Line
	9750 1600 9900 1600
Wire Wire Line
	9400 1700 9900 1700
Text Notes 10650 1800 0    50   ~ 0
FTDI Header\nGND\nUnused CTS\nVCC (3.3v)\nTX\nRX\nUnused DTR
Text GLabel 3400 1900 2    50   Input ~ 0
RX_FTDI
Wire Wire Line
	3000 1900 3400 1900
Text GLabel 3400 2100 2    50   Input ~ 0
TX_FTDI
Wire Wire Line
	3000 2100 3400 2100
Text Notes 4300 2000 2    50   ~ 0
TX to FTDI RX\nRX to FTDI TX
Text Notes 1800 1650 2    50   ~ 0
EN = Reset Pin??
$Comp
L Connector_Generic:Conn_01x06 J?
U 1 1 5DB2E25E
P 10100 1500
F 0 "J?" H 10180 1492 50  0000 L CNN
F 1 "Conn_01x06" H 10180 1401 50  0000 L CNN
F 2 "" H 10100 1500 50  0001 C CNN
F 3 "~" H 10100 1500 50  0001 C CNN
	1    10100 1500
	1    0    0    -1  
$EndComp
Wire Wire Line
	2400 4400 2400 4600
Text Notes 5400 2700 2    50   ~ 0
pin must be one of 0,2,4,12-15,25-27,32-39
Text GLabel 3250 3800 2    50   Input ~ 0
io_32
Text GLabel 3250 3900 2    50   Input ~ 0
io_33
Text GLabel 3250 4000 2    50   Input ~ 0
io_34
Text GLabel 3250 4100 2    50   Input ~ 0
io_35
Wire Wire Line
	3000 3800 3250 3800
Wire Wire Line
	3000 3900 3250 3900
Wire Wire Line
	3000 4000 3250 4000
Wire Wire Line
	3000 4100 3250 4100
Text Notes 3650 3450 0    50   ~ 0
296-50411-1-ND‎\n‎TLV75533PDBVR‎\nIC REG LINEAR 3.3V 500MA SOT23-5 \n\n1904-1010-1-ND‎\n‎ESP32-WROOM-32‎\nSMD MODULE, ESP32-D0WDQ6, 32MBIT 
$EndSCHEMATC
