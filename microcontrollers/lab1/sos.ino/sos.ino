


int LED_PINS[] = {3, 5, 6, 9, 10, 11};
int i = 0;
bool forward = true;


void setup() {
  // put your setup code here, to run once:
  pinMode(OUTPUT, LED_PINS[0]);
  pinMode(OUTPUT, LED_PINS[1]);
  pinMode(OUTPUT, LED_PINS[2]);
  pinMode(OUTPUT, LED_PINS[3]);
  pinMode(OUTPUT, LED_PINS[4]);
  pinMode(OUTPUT, LED_PINS[5]);
}

void loop() {
  
  sendS();

  //sendO()
  for(int i = 0; i < 3; i++) {
    analogWrite(11, 255);
    delay(500);
    analogWrite(11, 0);
    delay(100);
  }

  
  sendS();

  delay(3000);
}

void sendS() {
  for(int i = 0; i < 3; i++) {
    analogWrite(11, 255);
    delay(250);
    analogWrite(11, 0);
    delay(100);
  }
}
