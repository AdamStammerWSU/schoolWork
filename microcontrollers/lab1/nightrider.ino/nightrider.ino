


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
    for(int j = 0; j < 6; j++) {
      analogWrite(LED_PINS[j], 0);
    }
    analogWrite(LED_PINS[i], 255);
    delay(100);
    if(i == 5) {
      forward = false;
    }
    if(forward) {
      i++;
    } else i--;

    if(i == 0) {
      forward = true;
    }
}
