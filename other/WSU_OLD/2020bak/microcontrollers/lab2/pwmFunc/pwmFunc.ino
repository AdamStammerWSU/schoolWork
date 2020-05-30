int outPin = 2;

void setup() {
  Serial.begin(9600);
  pinMode(outPin, OUTPUT);
  
}

void loop() {
  for(int i = 0; i < 1000; i++) {
    
    analogueWrite(i, outPin);
  }

  for(int i = 1000; i > 0; i--) {
    
    analogueWrite(i, outPin);
  }
}

int analogueWrite(short onCycle, int pin) {
  if(onCycle == 0) {
    digitalWrite(pin, LOW);
  } else if(onCycle == 1000) {
    digitalWrite(pin, HIGH);
  } else {
    //a duty cycle that isn't 1 or 0

    digitalWrite(pin, HIGH);
    delayMicroseconds(onCycle);
    digitalWrite(pin, LOW);
    delayMicroseconds(1000 - onCycle);
  }
}
