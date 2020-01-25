


int LED_PINS[] = {3, 5, 6, 9, 10, 11};
int i = 0;
boolean forward = true;


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
  analogWrite(LED_PINS[0], i);
  analogWrite(LED_PINS[1], 255-i);

  if(forward)
    i++;
  else i--;

  if(i==255) {
    forward = false;
  }
  if(i == 0) {
    forward = true;
  }

  delay(10);
}
