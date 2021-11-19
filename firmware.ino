#include <SoftwareSerial.h>

int rxPin = 10;
int txPin = 11;
int VIBRATE_PIN = 3;
int SHOCK_PIN = 2;
int incomingByte = 0;

int downPin = 4;
int upPin = 5;

int modePin = 6;

SoftwareSerial bluetoothSerial(txPin, rxPin);

void setup() {
  Serial.begin(9600);
  bluetoothSerial.begin(9600);
  
  pinMode(VIBRATE_PIN, OUTPUT);
  pinMode(SHOCK_PIN, OUTPUT);
}

char c;

void loop() {
  if (bluetoothSerial.available()) {
    incomingByte = bluetoothSerial.read();
    Serial.println(incomingByte);
    if (incomingByte=='v') {
      digitalWrite(VIBRATE_PIN, HIGH); // sets the digital pin 13 on
      delay(200);            // waits for a second
      digitalWrite(VIBRATE_PIN, LOW);  // sets the digital pin 13 off
    }
    if (incomingByte=='s') {
      digitalWrite(SHOCK_PIN, HIGH); // sets the digital pin 13 on
      delay(200);            // waits for a second
      digitalWrite(SHOCK_PIN, LOW);  // sets the digital pin 13 off
    }
    Serial.println(incomingByte, DEC);
  }
  if (Serial.available() > 0) {
    incomingByte = Serial.read();
    if (incomingByte == 'v') {
      digitalWrite(VIBRATE_PIN, HIGH); // sets the digital pin 13 on
      delay(200);            // waits for a second
      digitalWrite(VIBRATE_PIN, LOW);  // sets the digital pin 13 off
    }
    if (incomingByte == 's') {
      digitalWrite(SHOCK_PIN, HIGH); // sets the digital pin 13 on
      delay(200);            // waits for a second
      digitalWrite(SHOCK_PIN, LOW);  // sets the digital pin 13 off
    }

    if (incomingByte == 'u') {
      digitalWrite(upPin, HIGH); // sets the digital pin 13 on
      delay(200);            // waits for a second
      digitalWrite(upPin, LOW);  // sets the digital pin 13 off
    }
    if (incomingByte == 'd') {
      digitalWrite(downPin, HIGH); // sets the digital pin 13 on
      delay(200);            // waits for a second
      digitalWrite(downPin, LOW);  // sets the digital pin 13 off
    }
    if (incomingByte == 'm') {
      digitalWrite(modePin, HIGH); // sets the digital pin 13 on
      delay(2000);            // waits for a second
      digitalWrite(modePin, LOW);  // sets the digital pin 13 off
    }



    
    Serial.println(incomingByte, DEC);
  }
}
