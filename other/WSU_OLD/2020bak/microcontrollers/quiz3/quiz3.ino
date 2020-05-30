/*
 * Adam Stammer
 * Microprocessors - Winona State
 * Spring 2020
 * Quiz 3
 * 
 */


//setup variables
int reading;
int pin = A0;
int startTime,t1;
float voltage, temp;


void setup() {
  //open Serial line
  Serial.begin(9600);
  //print data format
  Serial.println("time(ms),ADC,V,Temp(C),");
  //capture startTime
  startTime=millis();
}

void loop() {
  //read in from the LM34
  reading = analogRead(pin);
  //capture the currrent Time in relation to the start time
  t1=millis() - startTime;

  //convert adc input to voltage
  mVoltage = 5000*(reading/1023.0);
  //voltage to temp conversion 10mV/C
  tempF = (mVoltage / 10);

  //print out the data (time, reading, voltage, temp)
  Serial.print(t1);
  Serial.print(", ");
  Serial.print(reading);
  Serial.print(", ");
  Serial.print(voltage);
  Serial.print(", ");
  Serial.print(temp);

  //wait half a second
  delay(500);
}
