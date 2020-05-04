#include <LiquidCrystal.h>

int sensorPin = A1;
int sensorInput = 0;
double temp = 0.0;;
double voltIn = 0.0;
int x =0;
boolean heaterOn = false;
int HEATER_PIN = A2;

const int rs = 12, en = 11, d4 = 5, d5 = 4, d6 = 3, d7 = 2;

LiquidCrystal lcd(rs, en, d4, d5, d6, d7);

char row1[16];
String row2 = "Heater On";

int brightness = 100;

void setup() {
  Serial.begin(9600);
  pinMode(A1, INPUT);
  pinMode(A2, OUTPUT);
  pinMode(9, OUTPUT);
  pinMode(10, OUTPUT);
  analogWrite(9, 100);
  analogWrite(10, 0);
  analogWrite(A5, 0);

  lcd.begin(16, 2);
  lcd.print("howdy");
  
  Serial.println("Temperature, Sensor Read, Voltage Read");
}

void loop() {
  x++;
  delay(1000);
  sensorInput = analogRead(sensorPin);
  voltIn = ((double)sensorInput/1023.0) * 5000;
  temp = (voltIn - 500.0)/10.0;

  if(temp < 25.0) {
    heaterOn = true;
    digitalWrite(HEATER_PIN, HIGH);
    row2 = "Heater On ";
  } else {
    heaterOn = false;
    digitalWrite(HEATER_PIN, LOW);
    row2 = "Heater Off";
  }
  
  if(x < 50) {
    Serial.print(temp);
    Serial.print(", ");
    Serial.print(sensorInput);
    Serial.print(", ");
    Serial.print(voltIn);
    Serial.print("\n");
  }
  lcd.setCursor(0,0);
  //sprintf(row1, "%.3f C", (float) temp);
  lcd.print(temp);
  lcd.print(" C");
  lcd.setCursor(0, 1);
  lcd.print(row2);
}
