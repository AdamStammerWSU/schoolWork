


int LED_PINS[] = {3, 5, 6, 9, 10, 11};
int boomTime = 0;
bool booming = false;
int boomOrigin = 0;
int tickDelay = 50;
int boomTick = 0;

int boomPins[] = {-1, -1, -1, -1, -1};

int boomTickPattern[][5] = { {0, 2, 4, 2, 0},
                            {1, 2, 2, 2, 1},
                            {1, 2, 1, 2, 1},
                            {1, 1, 0, 1, 1},
                            {1, 0, 0, 0, 1},
                            {0, 0, 0, 0, 0}};


void setup() {
  Serial.begin(9600);
  randomSeed(analogRead(A0));
  for(int i = 0; i < 3; i++) {
    Serial.print(random(0, 99));
    Serial.print("\n");
  }
  Serial.print("\n");
  // put your setup code here, to run once:
  pinMode(OUTPUT, LED_PINS[0]);
  pinMode(OUTPUT, LED_PINS[1]);
  pinMode(OUTPUT, LED_PINS[2]);
  pinMode(OUTPUT, LED_PINS[3]);
  pinMode(OUTPUT, LED_PINS[4]);
  pinMode(OUTPUT, LED_PINS[5]);
}

void loop() {
  if(!booming) {
    //we want to generate a new boom randomly
    int x = random(0, 99);
    if(x > 49) {
      //generate a new boom at a random led location
      boomOrigin = random(0, 5);
      boomTime = millis();
      for(int i = 0; i < 5; i++) {
        int y = boomOrigin + (i - 2);
        if(y < 0)
          y = -1;
        boomPins[i] = LED_PINS[y];
      }
      
      Serial.print(boomOrigin);
      Serial.print("\n");
      for(int i = 0; i < 5; i++) {
        
      Serial.print(boomPins[i]);
      Serial.print("\n");
      }
      for(int i = 0; i < 5; i++) {
        if(boomPins[i] != -1) {
          analogWrite(boomPins[i], 63 * boomTickPattern[boomTick][i]);
        }
      }
      booming = true;
    } else {
      //delay for half a second and try again
      delay(500);
    }
  } else {
    //update the boom
    int t = millis();
    if((t - boomTime) >= tickDelay) {
      //tick the animation
      boomTick++;
      
      if(boomTick > 5) {
          booming = false;
          boomTime = 0;
          boomTick = 0;
      } else {
        boomTime = t;
        for(int i = 0; i < 5; i++) {
          if(boomPins[i] != -1) {
            analogWrite(boomPins[i], 63 * boomTickPattern[boomTick][i]);
          }
        }
      }
    }
    if(boomTick > 5) {
        booming = false;
    }
  }
  delay(100);
}
