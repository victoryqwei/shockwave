#include <SoftwareSerial.h>

int rxPin = 10;
int txPin = 11;
int VIBRATE_PIN = 3;
int SHOCK_PIN = 2;
int incomingByte = 0;

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
    Serial.println(incomingByte, DEC);
  }
}
