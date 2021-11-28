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

// 0 - Vibrate, 1 - Shock
int mode = 0;
int shock_level = 1;
int vibrate_level = 1;


// Presses a pin for ms time
void press_button(int pin, int ms) {
  digitalWrite(pin, HIGH);
  delay(ms);
  digitalWrite(pin, LOW);
  delay(ms);
}


// Set level give mode m (0/1) and level v
void set_level(int m, int v) {
  // Difference between levels
  if (mode != m) {
    press_button(modePin, 2000);
    mode = m;
  }

  int level;

  v = v - '0';

  if (mode == 0) {
    level = vibrate_level;
    vibrate_level = v;
  } else if (mode == 1) {
    level = shock_level;
    shock_level = v;
  }

  Serial.println(abs(level - v));

  for (int i = 0; i < abs(level - v); i++) {
    if (v > level) {
      press_button(upPin, 50);
    } else if (v < level) {
      press_button(downPin, 50);
    }
  }
}


// Set everything to 0 so we can keep track of values
void setup_remote() {
  for (int i = 0; i < 7; i++) {
    press_button(downPin, 50);
  }

  press_button(modePin, 2000);

  for (int i = 0; i < 15; i++) {
    press_button(downPin, 50);
  }

  mode = 1;

  Serial.println("Setup complete :D");
}


void setup() {
  Serial.begin(9600);
  bluetoothSerial.begin(9600);

  pinMode(VIBRATE_PIN, OUTPUT);
  pinMode(SHOCK_PIN, OUTPUT);

  setup_remote();
}


void loop() {
  if (bluetoothSerial.available()) {
    incomingByte = bluetoothSerial.read();
    Serial.println(incomingByte);
    
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
  }
  if (Serial.available() > 0) {
    String string = Serial.readString();

    int l = string.length();
    
    Serial.println(string);

    if (l == 1) {
      if (string == "v") {
        press_button(VIBRATE_PIN, 50);
      } else if (string == "s") {
        press_button(SHOCK_PIN, 50);
      } else if (string == "m") {
        digitalWrite(modePin, HIGH); // sets the digital pin 13 on
        delay(2000);            // waits for a second
        digitalWrite(modePin, LOW);  // sets the digital pin 13 off
      } else if (string == "r") {
        setup_remote();
      }
    } else if (l == 2)  {
      if (string[0] == 'v') {
        set_level(0, string[1]);
      } else if (string[0] == 's') {
        set_level(1, string[1]);
      }
    }
  }
  incomingByte = Serial.read();
//      if (incomingByte == 'v') {
//        digitalWrite(VIBRATE_PIN, HIGH); // sets the digital pin 13 on
//        delay(200);            // waits for a second
//        digitalWrite(VIBRATE_PIN, LOW);  // sets the digital pin 13 off
//      }
//      if (incomingByte == 's') {
//        digitalWrite(SHOCK_PIN, HIGH); // sets the digital pin 13 on
//        delay(200);            // waits for a second
//        digitalWrite(SHOCK_PIN, LOW);  // sets the digital pin 13 off
//      }
//  
//      if (incomingByte == 'u') {
//        digitalWrite(upPin, HIGH); // sets the digital pin 13 on
//        delay(200);            // waits for a second
//        digitalWrite(upPin, LOW);  // sets the digital pin 13 off
//      }
//      if (incomingByte == 'd') {
//        digitalWrite(downPin, HIGH); // sets the digital pin 13 on
//        delay(200);            // waits for a second
//        digitalWrite(downPin, LOW);  // sets the digital pin 13 off
//      }
//      if (incomingByte == 'm') {
//        digitalWrite(modePin, HIGH); // sets the digital pin 13 on
//        delay(2000);            // waits for a second
//        digitalWrite(modePin, LOW);  // sets the digital pin 13 off
//      }
}
