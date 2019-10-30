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
L RF_Module:ESP32-WROOM-32 U1
U 1 1 5DB29ADF
P 2400 3000
F 0 "U1" H 2400 4581 50  0000 C CNN
F 1 "ESP32-WROOM-32" H 2400 4490 50  0000 C CNN
F 2 "RF_Module:ESP32-WROOM-32" H 2400 1500 50  0001 C CNN
F 3 "https://www.espressif.com/sites/default/files/documentation/esp32-wroom-32_datasheet_en.pdf" H 2100 3050 50  0001 C CNN
	1    2400 3000
	1    0    0    -1  
$EndComp
Text GLabel 1550 1800 0    50   Input ~ 0
EN
Text GLabel 3200 1800 2    50   Input ~ 0
io_0
$Comp
L power:GND #PWR02
U 1 1 5DB2CD36
P 2400 4600
F 0 "#PWR02" H 2400 4350 50  0001 C CNN
F 1 "GND" H 2405 4427 50  0000 C CNN
F 2 "" H 2400 4600 50  0001 C CNN
F 3 "" H 2400 4600 50  0001 C CNN
	1    2400 4600
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR01
U 1 1 5DB2D728
P 2400 1350
F 0 "#PWR01" H 2400 1200 50  0001 C CNN
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
L power:GND #PWR025
U 1 1 5DB311C1
P 9350 1300
F 0 "#PWR025" H 9350 1050 50  0001 C CNN
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
Text GLabel 9750 1600 0    50   Input ~ 0
TX_FTDI
Text GLabel 9400 1700 0    50   Input ~ 0
RX_FTDI
Wire Wire Line
	9750 1600 9900 1600
Wire Wire Line
	9400 1700 9900 1700
Text Notes 10650 1800 0    50   ~ 0
FTDI Header\nGND\nUnused CTS\nUnused VCC (3.3v)\nTX\nRX\nUnused DTR
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
L Connector_Generic:Conn_01x06 J1
U 1 1 5DB2E25E
P 10100 1500
F 0 "J1" H 10180 1492 50  0000 L CNN
F 1 "Conn_01x06" H 10180 1401 50  0000 L CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x06_P2.54mm_Vertical" H 10100 1500 50  0001 C CNN
F 3 "~" H 10100 1500 50  0001 C CNN
	1    10100 1500
	1    0    0    -1  
$EndComp
Wire Wire Line
	2400 4400 2400 4600
Text Notes 5400 2700 2    50   ~ 0
pin must be one of 0,2,4,12-15,25-27,32-39\nto allow interrupts
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
Text Notes 3800 3900 0    50   ~ 0
Pin 32 = LOCK\n33 = DOOR
Text GLabel 3100 2400 2    50   Input ~ 0
io_12
Text GLabel 3100 2500 2    50   Input ~ 0
io_13
Text GLabel 3100 2600 2    50   Input ~ 0
io_14
Text GLabel 3100 2700 2    50   Input ~ 0
io_15
Wire Wire Line
	3000 2400 3100 2400
Wire Wire Line
	3000 2500 3100 2500
Wire Wire Line
	3000 2600 3100 2600
Wire Wire Line
	3000 2700 3100 2700
$Comp
L power:+BATT #PWR03
U 1 1 5DB952D3
P 6150 1350
F 0 "#PWR03" H 6150 1200 50  0001 C CNN
F 1 "+BATT" H 6165 1523 50  0000 C CNN
F 2 "" H 6150 1350 50  0001 C CNN
F 3 "" H 6150 1350 50  0001 C CNN
	1    6150 1350
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR09
U 1 1 5DB968B7
P 6650 2000
F 0 "#PWR09" H 6650 1750 50  0001 C CNN
F 1 "GND" H 6655 1827 50  0000 C CNN
F 2 "" H 6650 2000 50  0001 C CNN
F 3 "" H 6650 2000 50  0001 C CNN
	1    6650 2000
	1    0    0    -1  
$EndComp
$Comp
L Regulator_Linear:TLV75533PDBV U2
U 1 1 5DB96CBC
P 6650 1550
F 0 "U2" H 6650 1892 50  0000 C CNN
F 1 "TLV75533PDBV" H 6650 1801 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-23-5" H 6650 1875 50  0001 C CIN
F 3 "http://www.ti.com/lit/ds/symlink/tlv755p.pdf" H 6650 1600 50  0001 C CNN
	1    6650 1550
	1    0    0    -1  
$EndComp
Wire Wire Line
	6150 1350 6150 1450
Wire Wire Line
	6150 1450 6350 1450
Wire Wire Line
	6150 1450 6150 1550
Wire Wire Line
	6150 1550 6350 1550
Connection ~ 6150 1450
Wire Wire Line
	6650 1850 6650 1950
$Comp
L power:-BATT #PWR04
U 1 1 5DB9FE89
P 6150 1950
F 0 "#PWR04" H 6150 1800 50  0001 C CNN
F 1 "-BATT" H 6165 2123 50  0000 C CNN
F 2 "" H 6150 1950 50  0001 C CNN
F 3 "" H 6150 1950 50  0001 C CNN
	1    6150 1950
	1    0    0    -1  
$EndComp
Wire Wire Line
	6150 1950 6650 1950
Connection ~ 6650 1950
Wire Wire Line
	6650 1950 6650 2000
$Comp
L power:+3.3V #PWR014
U 1 1 5DBA0C76
P 7250 1450
F 0 "#PWR014" H 7250 1300 50  0001 C CNN
F 1 "+3.3V" H 7265 1623 50  0000 C CNN
F 2 "" H 7250 1450 50  0001 C CNN
F 3 "" H 7250 1450 50  0001 C CNN
	1    7250 1450
	1    0    0    -1  
$EndComp
Wire Wire Line
	6950 1450 7250 1450
Text Notes 7450 1050 2    50   ~ 0
consider if I need capacitors on the input output
Text GLabel 6000 2950 0    50   Input ~ 0
io_12
$Comp
L power:+3.3V #PWR05
U 1 1 5DBA6D12
P 6250 2550
F 0 "#PWR05" H 6250 2400 50  0001 C CNN
F 1 "+3.3V" H 6265 2723 50  0000 C CNN
F 2 "" H 6250 2550 50  0001 C CNN
F 3 "" H 6250 2550 50  0001 C CNN
	1    6250 2550
	1    0    0    -1  
$EndComp
$Comp
L Device:R R1
U 1 1 5DBA7655
P 6250 2800
F 0 "R1" H 6320 2846 50  0000 L CNN
F 1 "10k" H 6320 2755 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 6180 2800 50  0001 C CNN
F 3 "~" H 6250 2800 50  0001 C CNN
	1    6250 2800
	1    0    0    -1  
$EndComp
Wire Wire Line
	6000 2950 6250 2950
Wire Wire Line
	6250 2650 6250 2550
$Comp
L Switch:SW_Push SW1
U 1 1 5DBA8E8A
P 6600 2950
F 0 "SW1" H 6600 3235 50  0000 C CNN
F 1 "SW_IO12" H 6600 3144 50  0000 C CNN
F 2 "TerminalBlock_Phoenix:TerminalBlock_Phoenix_PT-1,5-2-5.0-H_1x02_P5.00mm_Horizontal" H 6600 3150 50  0001 C CNN
F 3 "~" H 6600 3150 50  0001 C CNN
	1    6600 2950
	1    0    0    -1  
$EndComp
Wire Wire Line
	6400 2950 6250 2950
Connection ~ 6250 2950
$Comp
L power:GND #PWR010
U 1 1 5DBA9E72
P 7000 2950
F 0 "#PWR010" H 7000 2700 50  0001 C CNN
F 1 "GND" H 7005 2777 50  0000 C CNN
F 2 "" H 7000 2950 50  0001 C CNN
F 3 "" H 7000 2950 50  0001 C CNN
	1    7000 2950
	1    0    0    -1  
$EndComp
Wire Wire Line
	7000 2950 6800 2950
Text GLabel 6000 3600 0    50   Input ~ 0
io_13
$Comp
L power:+3.3V #PWR06
U 1 1 5DBAC960
P 6250 3200
F 0 "#PWR06" H 6250 3050 50  0001 C CNN
F 1 "+3.3V" H 6265 3373 50  0000 C CNN
F 2 "" H 6250 3200 50  0001 C CNN
F 3 "" H 6250 3200 50  0001 C CNN
	1    6250 3200
	1    0    0    -1  
$EndComp
$Comp
L Device:R R2
U 1 1 5DBAC966
P 6250 3450
F 0 "R2" H 6320 3496 50  0000 L CNN
F 1 "10k" H 6320 3405 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 6180 3450 50  0001 C CNN
F 3 "~" H 6250 3450 50  0001 C CNN
	1    6250 3450
	1    0    0    -1  
$EndComp
Wire Wire Line
	6000 3600 6250 3600
Wire Wire Line
	6250 3300 6250 3200
$Comp
L Switch:SW_Push SW2
U 1 1 5DBAC96E
P 6600 3600
F 0 "SW2" H 6600 3885 50  0000 C CNN
F 1 "SW_IO13" H 6600 3794 50  0000 C CNN
F 2 "TerminalBlock_Phoenix:TerminalBlock_Phoenix_PT-1,5-2-5.0-H_1x02_P5.00mm_Horizontal" H 6600 3800 50  0001 C CNN
F 3 "~" H 6600 3800 50  0001 C CNN
	1    6600 3600
	1    0    0    -1  
$EndComp
Wire Wire Line
	6400 3600 6250 3600
Connection ~ 6250 3600
$Comp
L power:GND #PWR011
U 1 1 5DBAC976
P 7000 3600
F 0 "#PWR011" H 7000 3350 50  0001 C CNN
F 1 "GND" H 7005 3427 50  0000 C CNN
F 2 "" H 7000 3600 50  0001 C CNN
F 3 "" H 7000 3600 50  0001 C CNN
	1    7000 3600
	1    0    0    -1  
$EndComp
Wire Wire Line
	7000 3600 6800 3600
Text GLabel 6000 4300 0    50   Input ~ 0
io_14
$Comp
L power:+3.3V #PWR07
U 1 1 5DBAEFF3
P 6250 3900
F 0 "#PWR07" H 6250 3750 50  0001 C CNN
F 1 "+3.3V" H 6265 4073 50  0000 C CNN
F 2 "" H 6250 3900 50  0001 C CNN
F 3 "" H 6250 3900 50  0001 C CNN
	1    6250 3900
	1    0    0    -1  
$EndComp
$Comp
L Device:R R3
U 1 1 5DBAEFF9
P 6250 4150
F 0 "R3" H 6320 4196 50  0000 L CNN
F 1 "10k" H 6320 4105 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 6180 4150 50  0001 C CNN
F 3 "~" H 6250 4150 50  0001 C CNN
	1    6250 4150
	1    0    0    -1  
$EndComp
Wire Wire Line
	6000 4300 6250 4300
Wire Wire Line
	6250 4000 6250 3900
$Comp
L Switch:SW_Push SW3
U 1 1 5DBAF001
P 6600 4300
F 0 "SW3" H 6600 4585 50  0000 C CNN
F 1 "SW_IO14" H 6600 4494 50  0000 C CNN
F 2 "TerminalBlock_Phoenix:TerminalBlock_Phoenix_PT-1,5-2-5.0-H_1x02_P5.00mm_Horizontal" H 6600 4500 50  0001 C CNN
F 3 "~" H 6600 4500 50  0001 C CNN
	1    6600 4300
	1    0    0    -1  
$EndComp
Wire Wire Line
	6400 4300 6250 4300
Connection ~ 6250 4300
$Comp
L power:GND #PWR012
U 1 1 5DBAF009
P 7000 4300
F 0 "#PWR012" H 7000 4050 50  0001 C CNN
F 1 "GND" H 7005 4127 50  0000 C CNN
F 2 "" H 7000 4300 50  0001 C CNN
F 3 "" H 7000 4300 50  0001 C CNN
	1    7000 4300
	1    0    0    -1  
$EndComp
Wire Wire Line
	7000 4300 6800 4300
Text GLabel 6000 4950 0    50   Input ~ 0
io_15
$Comp
L power:+3.3V #PWR08
U 1 1 5DBB0539
P 6250 4550
F 0 "#PWR08" H 6250 4400 50  0001 C CNN
F 1 "+3.3V" H 6265 4723 50  0000 C CNN
F 2 "" H 6250 4550 50  0001 C CNN
F 3 "" H 6250 4550 50  0001 C CNN
	1    6250 4550
	1    0    0    -1  
$EndComp
$Comp
L Device:R R4
U 1 1 5DBB053F
P 6250 4800
F 0 "R4" H 6320 4846 50  0000 L CNN
F 1 "10k" H 6320 4755 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 6180 4800 50  0001 C CNN
F 3 "~" H 6250 4800 50  0001 C CNN
	1    6250 4800
	1    0    0    -1  
$EndComp
Wire Wire Line
	6000 4950 6250 4950
Wire Wire Line
	6250 4650 6250 4550
$Comp
L Switch:SW_Push SW4
U 1 1 5DBB0547
P 6600 4950
F 0 "SW4" H 6600 5235 50  0000 C CNN
F 1 "SW_IO15" H 6600 5144 50  0000 C CNN
F 2 "TerminalBlock_Phoenix:TerminalBlock_Phoenix_PT-1,5-2-5.0-H_1x02_P5.00mm_Horizontal" H 6600 5150 50  0001 C CNN
F 3 "~" H 6600 5150 50  0001 C CNN
	1    6600 4950
	1    0    0    -1  
$EndComp
Wire Wire Line
	6400 4950 6250 4950
Connection ~ 6250 4950
$Comp
L power:GND #PWR013
U 1 1 5DBB054F
P 7000 4950
F 0 "#PWR013" H 7000 4700 50  0001 C CNN
F 1 "GND" H 7005 4777 50  0000 C CNN
F 2 "" H 7000 4950 50  0001 C CNN
F 3 "" H 7000 4950 50  0001 C CNN
	1    7000 4950
	1    0    0    -1  
$EndComp
Wire Wire Line
	7000 4950 6800 4950
Text GLabel 7650 2900 0    50   Input ~ 0
io_32
$Comp
L power:+3.3V #PWR017
U 1 1 5DBB1ED1
P 7900 2500
F 0 "#PWR017" H 7900 2350 50  0001 C CNN
F 1 "+3.3V" H 7915 2673 50  0000 C CNN
F 2 "" H 7900 2500 50  0001 C CNN
F 3 "" H 7900 2500 50  0001 C CNN
	1    7900 2500
	1    0    0    -1  
$EndComp
$Comp
L Device:R R5
U 1 1 5DBB1ED7
P 7900 2750
F 0 "R5" H 7970 2796 50  0000 L CNN
F 1 "10k" H 7970 2705 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 7830 2750 50  0001 C CNN
F 3 "~" H 7900 2750 50  0001 C CNN
	1    7900 2750
	1    0    0    -1  
$EndComp
Wire Wire Line
	7650 2900 7900 2900
Wire Wire Line
	7900 2600 7900 2500
$Comp
L Switch:SW_Push SW5
U 1 1 5DBB1EDF
P 8250 2900
F 0 "SW5" H 8250 3185 50  0000 C CNN
F 1 "SW_IO32" H 8250 3094 50  0000 C CNN
F 2 "TerminalBlock_Phoenix:TerminalBlock_Phoenix_PT-1,5-2-5.0-H_1x02_P5.00mm_Horizontal" H 8250 3100 50  0001 C CNN
F 3 "~" H 8250 3100 50  0001 C CNN
	1    8250 2900
	1    0    0    -1  
$EndComp
Wire Wire Line
	8050 2900 7900 2900
Connection ~ 7900 2900
$Comp
L power:GND #PWR021
U 1 1 5DBB1EE7
P 8650 2900
F 0 "#PWR021" H 8650 2650 50  0001 C CNN
F 1 "GND" H 8655 2727 50  0000 C CNN
F 2 "" H 8650 2900 50  0001 C CNN
F 3 "" H 8650 2900 50  0001 C CNN
	1    8650 2900
	1    0    0    -1  
$EndComp
Wire Wire Line
	8650 2900 8450 2900
Text GLabel 7650 3550 0    50   Input ~ 0
io_33
$Comp
L power:+3.3V #PWR018
U 1 1 5DBB3767
P 7900 3150
F 0 "#PWR018" H 7900 3000 50  0001 C CNN
F 1 "+3.3V" H 7915 3323 50  0000 C CNN
F 2 "" H 7900 3150 50  0001 C CNN
F 3 "" H 7900 3150 50  0001 C CNN
	1    7900 3150
	1    0    0    -1  
$EndComp
$Comp
L Device:R R6
U 1 1 5DBB376D
P 7900 3400
F 0 "R6" H 7970 3446 50  0000 L CNN
F 1 "10k" H 7970 3355 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 7830 3400 50  0001 C CNN
F 3 "~" H 7900 3400 50  0001 C CNN
	1    7900 3400
	1    0    0    -1  
$EndComp
Wire Wire Line
	7650 3550 7900 3550
Wire Wire Line
	7900 3250 7900 3150
$Comp
L Switch:SW_Push SW6
U 1 1 5DBB3775
P 8250 3550
F 0 "SW6" H 8250 3835 50  0000 C CNN
F 1 "SW_IO33" H 8250 3744 50  0000 C CNN
F 2 "TerminalBlock_Phoenix:TerminalBlock_Phoenix_PT-1,5-2-5.0-H_1x02_P5.00mm_Horizontal" H 8250 3750 50  0001 C CNN
F 3 "~" H 8250 3750 50  0001 C CNN
	1    8250 3550
	1    0    0    -1  
$EndComp
Wire Wire Line
	8050 3550 7900 3550
Connection ~ 7900 3550
$Comp
L power:GND #PWR022
U 1 1 5DBB377D
P 8650 3550
F 0 "#PWR022" H 8650 3300 50  0001 C CNN
F 1 "GND" H 8655 3377 50  0000 C CNN
F 2 "" H 8650 3550 50  0001 C CNN
F 3 "" H 8650 3550 50  0001 C CNN
	1    8650 3550
	1    0    0    -1  
$EndComp
Wire Wire Line
	8650 3550 8450 3550
Text GLabel 7650 4250 0    50   Input ~ 0
io_34
$Comp
L power:+3.3V #PWR019
U 1 1 5DBB6B68
P 7900 3850
F 0 "#PWR019" H 7900 3700 50  0001 C CNN
F 1 "+3.3V" H 7915 4023 50  0000 C CNN
F 2 "" H 7900 3850 50  0001 C CNN
F 3 "" H 7900 3850 50  0001 C CNN
	1    7900 3850
	1    0    0    -1  
$EndComp
$Comp
L Device:R R7
U 1 1 5DBB6B6E
P 7900 4100
F 0 "R7" H 7970 4146 50  0000 L CNN
F 1 "10k" H 7970 4055 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 7830 4100 50  0001 C CNN
F 3 "~" H 7900 4100 50  0001 C CNN
	1    7900 4100
	1    0    0    -1  
$EndComp
Wire Wire Line
	7650 4250 7900 4250
Wire Wire Line
	7900 3950 7900 3850
$Comp
L Switch:SW_Push SW7
U 1 1 5DBB6B76
P 8250 4250
F 0 "SW7" H 8250 4535 50  0000 C CNN
F 1 "SW_IO34" H 8250 4444 50  0000 C CNN
F 2 "TerminalBlock_Phoenix:TerminalBlock_Phoenix_PT-1,5-2-5.0-H_1x02_P5.00mm_Horizontal" H 8250 4450 50  0001 C CNN
F 3 "~" H 8250 4450 50  0001 C CNN
	1    8250 4250
	1    0    0    -1  
$EndComp
Wire Wire Line
	8050 4250 7900 4250
Connection ~ 7900 4250
$Comp
L power:GND #PWR023
U 1 1 5DBB6B7E
P 8650 4250
F 0 "#PWR023" H 8650 4000 50  0001 C CNN
F 1 "GND" H 8655 4077 50  0000 C CNN
F 2 "" H 8650 4250 50  0001 C CNN
F 3 "" H 8650 4250 50  0001 C CNN
	1    8650 4250
	1    0    0    -1  
$EndComp
Wire Wire Line
	8650 4250 8450 4250
Text GLabel 7650 4950 0    50   Input ~ 0
io_35
$Comp
L power:+3.3V #PWR020
U 1 1 5DBB88DF
P 7900 4550
F 0 "#PWR020" H 7900 4400 50  0001 C CNN
F 1 "+3.3V" H 7915 4723 50  0000 C CNN
F 2 "" H 7900 4550 50  0001 C CNN
F 3 "" H 7900 4550 50  0001 C CNN
	1    7900 4550
	1    0    0    -1  
$EndComp
$Comp
L Device:R R8
U 1 1 5DBB88E5
P 7900 4800
F 0 "R8" H 7970 4846 50  0000 L CNN
F 1 "10k" H 7970 4755 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 7830 4800 50  0001 C CNN
F 3 "~" H 7900 4800 50  0001 C CNN
	1    7900 4800
	1    0    0    -1  
$EndComp
Wire Wire Line
	7650 4950 7900 4950
Wire Wire Line
	7900 4650 7900 4550
$Comp
L Switch:SW_Push SW8
U 1 1 5DBB88ED
P 8250 4950
F 0 "SW8" H 8250 5235 50  0000 C CNN
F 1 "SW_IO35" H 8250 5144 50  0000 C CNN
F 2 "TerminalBlock_Phoenix:TerminalBlock_Phoenix_PT-1,5-2-5.0-H_1x02_P5.00mm_Horizontal" H 8250 5150 50  0001 C CNN
F 3 "~" H 8250 5150 50  0001 C CNN
	1    8250 4950
	1    0    0    -1  
$EndComp
Wire Wire Line
	8050 4950 7900 4950
Connection ~ 7900 4950
$Comp
L power:GND #PWR024
U 1 1 5DBB88F5
P 8650 4950
F 0 "#PWR024" H 8650 4700 50  0001 C CNN
F 1 "GND" H 8655 4777 50  0000 C CNN
F 2 "" H 8650 4950 50  0001 C CNN
F 3 "" H 8650 4950 50  0001 C CNN
	1    8650 4950
	1    0    0    -1  
$EndComp
Wire Wire Line
	8650 4950 8450 4950
Text GLabel 9400 2750 0    50   Input ~ 0
EN
$Comp
L power:+3.3V #PWR026
U 1 1 5DBC4F58
P 9650 2350
F 0 "#PWR026" H 9650 2200 50  0001 C CNN
F 1 "+3.3V" H 9665 2523 50  0000 C CNN
F 2 "" H 9650 2350 50  0001 C CNN
F 3 "" H 9650 2350 50  0001 C CNN
	1    9650 2350
	1    0    0    -1  
$EndComp
$Comp
L Device:R R9
U 1 1 5DBC4F5E
P 9650 2600
F 0 "R9" H 9720 2646 50  0000 L CNN
F 1 "10k" H 9720 2555 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 9580 2600 50  0001 C CNN
F 3 "~" H 9650 2600 50  0001 C CNN
	1    9650 2600
	1    0    0    -1  
$EndComp
Wire Wire Line
	9400 2750 9650 2750
Wire Wire Line
	9650 2450 9650 2350
$Comp
L Switch:SW_Push SW_EN1
U 1 1 5DBC4F66
P 10000 2750
F 0 "SW_EN1" H 10000 3035 50  0000 C CNN
F 1 "SW_EN" H 10000 2944 50  0000 C CNN
F 2 "Button_Switch_THT:SW_PUSH_6mm" H 10000 2950 50  0001 C CNN
F 3 "~" H 10000 2950 50  0001 C CNN
	1    10000 2750
	1    0    0    -1  
$EndComp
Wire Wire Line
	9800 2750 9650 2750
Connection ~ 9650 2750
$Comp
L power:GND #PWR028
U 1 1 5DBC4F6E
P 10400 2750
F 0 "#PWR028" H 10400 2500 50  0001 C CNN
F 1 "GND" H 10405 2577 50  0000 C CNN
F 2 "" H 10400 2750 50  0001 C CNN
F 3 "" H 10400 2750 50  0001 C CNN
	1    10400 2750
	1    0    0    -1  
$EndComp
Wire Wire Line
	10400 2750 10200 2750
Text GLabel 9400 3400 0    50   Input ~ 0
io_0
$Comp
L power:+3.3V #PWR027
U 1 1 5DBD04B1
P 9650 3000
F 0 "#PWR027" H 9650 2850 50  0001 C CNN
F 1 "+3.3V" H 9665 3173 50  0000 C CNN
F 2 "" H 9650 3000 50  0001 C CNN
F 3 "" H 9650 3000 50  0001 C CNN
	1    9650 3000
	1    0    0    -1  
$EndComp
$Comp
L Device:R R10
U 1 1 5DBD04B7
P 9650 3250
F 0 "R10" H 9720 3296 50  0000 L CNN
F 1 "10k" H 9720 3205 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 9580 3250 50  0001 C CNN
F 3 "~" H 9650 3250 50  0001 C CNN
	1    9650 3250
	1    0    0    -1  
$EndComp
Wire Wire Line
	9400 3400 9650 3400
Wire Wire Line
	9650 3100 9650 3000
$Comp
L Switch:SW_Push SW_RESET1
U 1 1 5DBD04BF
P 10000 3400
F 0 "SW_RESET1" H 10000 3685 50  0000 C CNN
F 1 "SW_RESET" H 10000 3594 50  0000 C CNN
F 2 "Button_Switch_THT:SW_PUSH_6mm" H 10000 3600 50  0001 C CNN
F 3 "~" H 10000 3600 50  0001 C CNN
	1    10000 3400
	1    0    0    -1  
$EndComp
Wire Wire Line
	9800 3400 9650 3400
Connection ~ 9650 3400
$Comp
L power:GND #PWR029
U 1 1 5DBD04C7
P 10400 3400
F 0 "#PWR029" H 10400 3150 50  0001 C CNN
F 1 "GND" H 10405 3227 50  0000 C CNN
F 2 "" H 10400 3400 50  0001 C CNN
F 3 "" H 10400 3400 50  0001 C CNN
	1    10400 3400
	1    0    0    -1  
$EndComp
Wire Wire Line
	10400 3400 10200 3400
Text Notes 6950 5650 0    50   ~ 0
en is like a reset button\nio 0 and en held down enables programming\n\nin the future I'm thinking one of the io should be jumped to enter programming\nmode, and i can just do it OTA
Text GLabel 3100 2800 2    50   Input ~ 0
io_16
Wire Wire Line
	3100 2800 3000 2800
Text GLabel 9400 4200 0    50   Input ~ 0
io_16
$Comp
L Device:LED D1
U 1 1 5DBFF36A
P 10100 4200
F 0 "D1" H 10093 3945 50  0000 C CNN
F 1 "LED" H 10093 4036 50  0000 C CNN
F 2 "LED_SMD:LED_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 10100 4200 50  0001 C CNN
F 3 "~" H 10100 4200 50  0001 C CNN
	1    10100 4200
	-1   0    0    1   
$EndComp
$Comp
L Device:R R11
U 1 1 5DC07920
P 9650 4200
F 0 "R11" V 9443 4200 50  0000 C CNN
F 1 "330" V 9534 4200 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 9580 4200 50  0001 C CNN
F 3 "~" H 9650 4200 50  0001 C CNN
	1    9650 4200
	0    1    1    0   
$EndComp
Wire Wire Line
	9400 4200 9500 4200
Wire Wire Line
	9800 4200 9950 4200
$Comp
L power:GND #PWR030
U 1 1 5DC173AB
P 10400 4300
F 0 "#PWR030" H 10400 4050 50  0001 C CNN
F 1 "GND" H 10405 4127 50  0000 C CNN
F 2 "" H 10400 4300 50  0001 C CNN
F 3 "" H 10400 4300 50  0001 C CNN
	1    10400 4300
	1    0    0    -1  
$EndComp
Wire Wire Line
	10250 4200 10400 4200
Wire Wire Line
	10400 4200 10400 4300
Text Notes 9200 3900 0    50   ~ 0
blonky status led
Text Notes 7400 7500 0    50   ~ 0
door monitor board, 8 input, ftdi programming header
Text Notes 10600 7650 0    50   ~ 0
1
Text Notes 8150 7650 0    50   ~ 0
10/29/2019
Text Notes 8800 7300 0    50   ~ 0
Chris Johnston
Text Notes 3400 2850 0    50   ~ 0
16 = LED
Text Notes 8550 1950 0    50   ~ 0
ensure tx and rx are 3.3v
Text Notes 8750 1100 0    50   ~ 0
FTDI header cannot power esp32 for programming\nInstead, bridge together the grounds\nand supply power with battery through regulator when\nprogramming
Text Notes 6200 900  0    50   ~ 0
range is up to 5.5v
$Comp
L Connector_Generic:Conn_01x02 JBAT1
U 1 1 5DC8C739
P 7650 1700
F 0 "JBAT1" H 7730 1692 50  0000 L CNN
F 1 "Battery (Max 5.5V DC)" H 7730 1601 50  0000 L CNN
F 2 "TerminalBlock_Phoenix:TerminalBlock_Phoenix_PT-1,5-2-5.0-H_1x02_P5.00mm_Horizontal" H 7650 1700 50  0001 C CNN
F 3 "~" H 7650 1700 50  0001 C CNN
	1    7650 1700
	1    0    0    -1  
$EndComp
$Comp
L power:+BATT #PWR016
U 1 1 5DC8D670
P 7350 1700
F 0 "#PWR016" H 7350 1550 50  0001 C CNN
F 1 "+BATT" H 7365 1873 50  0000 C CNN
F 2 "" H 7350 1700 50  0001 C CNN
F 3 "" H 7350 1700 50  0001 C CNN
	1    7350 1700
	1    0    0    -1  
$EndComp
$Comp
L power:-BATT #PWR015
U 1 1 5DC8DCAB
P 7250 1800
F 0 "#PWR015" H 7250 1650 50  0001 C CNN
F 1 "-BATT" H 7265 1973 50  0000 C CNN
F 2 "" H 7250 1800 50  0001 C CNN
F 3 "" H 7250 1800 50  0001 C CNN
	1    7250 1800
	1    0    0    -1  
$EndComp
Wire Wire Line
	7350 1700 7450 1700
Wire Wire Line
	7250 1800 7450 1800
$EndSCHEMATC
