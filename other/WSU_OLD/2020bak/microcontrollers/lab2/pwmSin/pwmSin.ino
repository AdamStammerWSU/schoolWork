int outPin = 3;

void setup() {
  Serial.begin(9600);
  pinMode(outPin, OUTPUT);
  
}

void loop() {
  analogueWriteSin(200, outPin, 1000);
}

int analogueWrite(float duty, long period, int pin) {
    digitalWrite(pin, HIGH);
    delayMicroseconds(duty*period);
    digitalWrite(pin, LOW);
    delayMicroseconds(period - (duty*period));
    
}
int analogueWriteSin(long cycle, int pin, int duration) {
  long startTime = millis();
  
  for(int i = 0; i < cycle; i++) {
    float f = i * 2* 3.14;
    analogueWrite((sin((f/cycle))+1.0)/2.0, cycle, pin);
  }
}
