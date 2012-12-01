# R/W pin is pulled low (write only)
# 'enable' pin is toggled to write data to the registers

# Pin layout for LCD, the PI GPIO pins are between brackets, the wiringPI pinnumber is after the slash:
# 01 Ground
# 02 VCC - 5v
# 03 Contrast adjustment (VO) from potentio meter
# 04 (25/6) Register select (RS), RS=0: Command, RS=1: Data
# 05 (1/?) Read/Write (R/W) R/W=0: Write, R/W=1: read (This pin is not used/always set to 1)
# 06 (24/5) Clock (Enable) Falling edge triggered
# 07 Bit 0 (Not used in 4-bit operation)
# 08 Bit 1 (Not used in 4-bit operation)
# 09 Bit 2 (Not used in 4-bit operation)
# 10 Bit 3 (Not used in 4-bit operation)
# 11 (23/4) Bit 4 
# 12 (17/0) Bit 5
# 13 (21/2) Bit 6
# 14 (22/3) Bit 7
# 15 Backlight LED Anode (+)
# 16 Backlight LED Cathode (-)

require 'wiringpi'

T_MS = 1/100000 #for testing not MS
P_RS = 6
P_RW = 99 #Bogus number not used at this moment
P_EN = 5
P_D0 = 99 #Bogus number not used at this moment
P_D1 = 99 #Bogus number not used at this moment
P_D2 = 99 #Bogus number not used at this moment
P_D3 = 99 #Bogus number not used at this moment
P_D4 = 4
P_D5 = 0
P_D6 = 2
P_D7 = 3
ON   = 1
OFF  = 0

Wiringpi.wiringPiSetup

# Set all pins to output mode (not sure if this is needed)
Wiringpi.pinMode(P_RS, 1)
Wiringpi.pinMode(P_EN, 1)
Wiringpi.pinMode(P_D4, 1)
Wiringpi.pinMode(P_D5, 1)
Wiringpi.pinMode(P_D6, 1)
Wiringpi.pinMode(P_D7, 1)

def pulseEnable()
  # Indicate to LCD that command should be 'executed'
  Wiringpi.digitalWrite(P_EN, 0)
  sleep T_MS
  Wiringpi.digitalWrite(P_EN, 1)
  sleep T_MS
  Wiringpi.digitalWrite(P_EN, 0)
  sleep T_MS
end

def set4bitMode()
  # Set function to 4 bit operation
  Wiringpi.digitalWrite(P_RS, 0)
 #Wiringpi.digitalWrite(P_RW, 0)
  Wiringpi.digitalWrite(P_D7, 0)
  Wiringpi.digitalWrite(P_D6, 0)
  Wiringpi.digitalWrite(P_D5, 1)
  Wiringpi.digitalWrite(P_D4, 0)
  pulseEnable()

  Wiringpi.digitalWrite(P_RS, 0)
 #Wiringpi.digitalWrite(P_RW, 0)
  Wiringpi.digitalWrite(P_D7, 0)
  Wiringpi.digitalWrite(P_D6, 0)
  Wiringpi.digitalWrite(P_D5, 1)
  Wiringpi.digitalWrite(P_D4, 0)
  pulseEnable()

  # Set 1 line display
  Wiringpi.digitalWrite(P_RS, 0)
 #Wiringpi.digitalWrite(P_RW, 0)
  Wiringpi.digitalWrite(P_D7, 0)
  Wiringpi.digitalWrite(P_D6, 0)
  pulseEnable()
end

def display(display, cursor, block)
  # Turn on display and cursor
  Wiringpi.digitalWrite(P_RS, 0)
 #Wiringpi.digitalWrite(P_RW, 0)
  Wiringpi.digitalWrite(P_D7, 0)
  Wiringpi.digitalWrite(P_D6, 0)
  Wiringpi.digitalWrite(P_D5, 0)
  Wiringpi.digitalWrite(P_D4, 0)
  pulseEnable()

  Wiringpi.digitalWrite(P_RS, 0)
 #Wiringpi.digitalWrite(P_RW, 0)
  Wiringpi.digitalWrite(P_D7, 1)
  Wiringpi.digitalWrite(P_D6, display) # 1 = 0n
  Wiringpi.digitalWrite(P_D5, cursor) # 1 = Cursor on, 0 = Cursor off
  Wiringpi.digitalWrite(P_D4, block) # 1 = Block, 0 = Underline cursor
  pulseEnable()
end

def setEntryMode()
  # Entry mode set
  Wiringpi.digitalWrite(P_RS, 0)
 #Wiringpi.digitalWrite(P_RW, 0)
  Wiringpi.digitalWrite(P_D7, 0)
  Wiringpi.digitalWrite(P_D6, 0)
  Wiringpi.digitalWrite(P_D5, 0)
  Wiringpi.digitalWrite(P_D4, 0)
  pulseEnable()

  Wiringpi.digitalWrite(P_RS, 0)
 #Wiringpi.digitalWrite(P_RW, 0)
  Wiringpi.digitalWrite(P_D7, 0)
  Wiringpi.digitalWrite(P_D6, 1)
  Wiringpi.digitalWrite(P_D5, 1)
  Wiringpi.digitalWrite(P_D4, 0)
  pulseEnable()
end

def write()
  # Write data to CGRAM/DDRAM
  Wiringpi.digitalWrite(P_RS, 1)
 #Wiringpi.digitalWrite(P_RW, 0)
  Wiringpi.digitalWrite(P_D7, 0)
  Wiringpi.digitalWrite(P_D6, 1)
  Wiringpi.digitalWrite(P_D5, 0)
  Wiringpi.digitalWrite(P_D4, 0)
  pulseEnable()

  Wiringpi.digitalWrite(P_RS, 1)
 #Wiringpi.digitalWrite(P_RW, 0)
  Wiringpi.digitalWrite(P_D7, 1)
  Wiringpi.digitalWrite(P_D6, 0)
  Wiringpi.digitalWrite(P_D5, 0)
  Wiringpi.digitalWrite(P_D4, 0)
  pulseEnable()
end

def cls()
  # Clear all data from screen
  Wiringpi.digitalWrite(P_RS, 0)
 #Wiringpi.digitalWrite(P_RW, 0)
  Wiringpi.digitalWrite(P_D7, 0)
  Wiringpi.digitalWrite(P_D6, 0)
  Wiringpi.digitalWrite(P_D5, 0)
  Wiringpi.digitalWrite(P_D4, 0)
  pulseEnable()

  Wiringpi.digitalWrite(P_RS, 0)
 #Wiringpi.digitalWrite(P_RW, 0)
  Wiringpi.digitalWrite(P_D7, 0)
  Wiringpi.digitalWrite(P_D6, 0)
  Wiringpi.digitalWrite(P_D5, 1)
  Wiringpi.digitalWrite(P_D4, 0)
  pulseEnable()

end

def resetDisplay()
  set4bitMode()
  display(ON, ON, ON)
  #setEntryMode()
  #cls()
end

resetDisplay()
#sleep T_MS
write()
#sleep T_MS
#write()
