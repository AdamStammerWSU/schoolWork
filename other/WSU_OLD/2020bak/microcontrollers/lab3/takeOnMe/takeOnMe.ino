//A-ha!
//by GeneralSpud

// For0 this to work, we need the pitches library

#include "pitches.h"

// Two things need to be created: the array for the notes of the melody (in order)
// and the duration of each (think of it like sheet music in two parts)

// BOTH ARRAYS MUST BE THE SAME SIZE!

// The melody array 
int melody[] = {
  NOTE_FS5, NOTE_FS5, NOTE_D5, NOTE_B4, NOTE_B4, NOTE_E5, 
  NOTE_E5, NOTE_E5, NOTE_GS5, NOTE_GS5, NOTE_A5, NOTE_B5, 
  NOTE_A5, NOTE_A5, NOTE_A5, NOTE_E5, NOTE_D5, NOTE_FS5, 
  NOTE_FS5, NOTE_FS5, NOTE_E5, NOTE_E5, NOTE_FS5, NOTE_E5
};

// The note duration, 8 = 8th note, 4 = quarter note, etc.
int durations[] = {
  8, 8, 8, 4, 4, 4, 
  4, 5, 8, 8, 8, 8, 
  8, 8, 8, 4, 4, 4, 
  4, 5, 8, 8, 8, 8
};
// determine the length of the arrays to use in the loop iteration
int songLength = sizeof(melody)/sizeof(melody[0]);
void setup() {
 //We don't need anything here
 double test = 10.0f;
}

void loop() {
  // Iterate through both arrays
  // Notice how the iteration variable thisNote is created in the parenthesis
  // The for loop stops when it is equal to the size of the melody array
  for (int thisNote = 0; thisNote < songLength; thisNote++){
    analogueWriteSin(200, 3, 1000);
  }
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
