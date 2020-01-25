int powerTransistor = 13;
int h1 = 9;
int h2 = 8;
int h3 = 5;
int h4 = 4;

int pole1a = 7;
int pole1b = 6;
int pole2a = 3;
int pole2b = 2;

int stepDelay = 35;

void setup() {
  pinMode(powerTransistor, OUTPUT);
  digitalWrite(powerTransistor, LOW);

  pinMode(h1, OUTPUT);
  pinMode(h2, OUTPUT);
  pinMode(h3, OUTPUT);
  pinMode(h4, OUTPUT);

  pinMode(pole1a, OUTPUT);
  pinMode(pole1b, OUTPUT);
  pinMode(pole2a, OUTPUT);
  pinMode(pole2b, OUTPUT);
  
}

void loop() {
  stepCounterC();
}

void stepCounter() {
  digitalWrite(powerTransistor, LOW); // turn off the power

  digitalWrite(h1, LOW);
  digitalWrite(h2, LOW);
  digitalWrite(h3, HIGH);
  digitalWrite(h4, HIGH); //SET OUTPUT TO + -

  tPole2(false);
  
  tPole1(true);

  digitalWrite(powerTransistor, HIGH); //TURN THE POWER ON
  delay(stepDelay); //wait for the motor to step


  digitalWrite(powerTransistor, LOW); // turn off the power

  digitalWrite(h1, HIGH);
  digitalWrite(h2, HIGH);
  digitalWrite(h3, LOW);
  digitalWrite(h4, LOW); //SET OUTPUT TO - +
  
  tPole1(false);

  tPole2(true);

  digitalWrite(powerTransistor, HIGH); //TURN THE POWER ON
  delay(stepDelay); //wait for the motor to step


  digitalWrite(powerTransistor, LOW); // turn off the power

  digitalWrite(h1, LOW);
  digitalWrite(h2, LOW);
  digitalWrite(h3, HIGH);
  digitalWrite(h4, HIGH); //SET OUTPUT TO + -

  tPole2(false);
  
  tPole1(true);

  digitalWrite(powerTransistor, HIGH); //TURN THE POWER ON
  delay(stepDelay); //wait for the motor to step


  digitalWrite(powerTransistor, LOW); // turn off the power

  digitalWrite(h1, LOW);
  digitalWrite(h2, LOW);
  digitalWrite(h3, HIGH);
  digitalWrite(h4, HIGH); //SET OUTPUT TO - +
  
  tPole1(false);

  tPole2(true);

  digitalWrite(powerTransistor, HIGH); //TURN THE POWER ON
  delay(stepDelay); //wait for the motor to step
}


void stepCounterC() {
  digitalWrite(powerTransistor, LOW); // turn off the power

  digitalWrite(h1, HIGH);
  digitalWrite(h2, HIGH);
  digitalWrite(h3, LOW);
  digitalWrite(h4, LOW); //SET OUTPUT TO + -

  tPole2(false);
  
  tPole1(true);

  digitalWrite(powerTransistor, HIGH); //TURN THE POWER ON
  delay(stepDelay); //wait for the motor to step


  digitalWrite(powerTransistor, LOW); // turn off the power

  digitalWrite(h1, HIGH);
  digitalWrite(h2, HIGH);
  digitalWrite(h3, LOW);
  digitalWrite(h4, LOW); //SET OUTPUT TO - +
  
  tPole1(false);

  tPole2(true);

  digitalWrite(powerTransistor, HIGH); //TURN THE POWER ON
  delay(stepDelay); //wait for the motor to step


  digitalWrite(powerTransistor, LOW); // turn off the power

  digitalWrite(h1, LOW);
  digitalWrite(h2, LOW);
  digitalWrite(h3, HIGH);
  digitalWrite(h4, HIGH); //SET OUTPUT TO + -

  tPole2(false);
  
  tPole1(true);

  digitalWrite(powerTransistor, HIGH); //TURN THE POWER ON
  delay(stepDelay); //wait for the motor to step


  digitalWrite(powerTransistor, LOW); // turn off the power

  digitalWrite(h1, LOW);
  digitalWrite(h2, LOW);
  digitalWrite(h3, HIGH);
  digitalWrite(h4, HIGH); //SET OUTPUT TO - +
  
  tPole1(false);

  tPole2(true);

  digitalWrite(powerTransistor, HIGH); //TURN THE POWER ON
  delay(stepDelay); //wait for the motor to step
}

void th1(bool b) {
  int x = LOW;
  if(b)
   x = HIGH;
  digitalWrite(h1, x);
  digitalWrite(h2, x);
}
void th2(bool b) {
  int x = LOW;
  if(b)
   x = HIGH;
  digitalWrite(h2, x);
  digitalWrite(h3, x);
}

void tPole1(bool b) {
  if(b) {
    digitalWrite(pole1a, HIGH);
    digitalWrite(pole1b, HIGH);
  } else {
    digitalWrite(pole1a, LOW);
    digitalWrite(pole1b, LOW);
  }
}
void tPole2(bool b) {
  if(b) {
    digitalWrite(pole2a, HIGH);
    digitalWrite(pole2b, HIGH);
  } else {
    digitalWrite(pole2a, LOW);
    digitalWrite(pole2b, LOW);
  }
}
