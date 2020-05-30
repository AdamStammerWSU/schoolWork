int outPin = 2;

void setup() {
  pinMode(outPin, OUTPUT);
  
}

void loop() {
  analogueWrite(.5, 1000, outPin);
}

int analogueWrite(float duty, long cycle, int pin) {
    digitalWrite(pin, HIGH);
    delayMicroseconds(duty*cycle);
    digitalWrite(pin, LOW);
    delayMicroseconds(cycle - (duty*cycle));
    
}
