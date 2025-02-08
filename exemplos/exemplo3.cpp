#include <Arduino.h>
#include <WiFi.h>

int sensorTemp, buzzer, tempCelsius;

void setup() {
Serial.begin(115200);
sensorTemp = 34;
buzzer = 5;
pinMode(sensorTemp, INPUT);
pinMode(buzzer, OUTPUT);
}
void loop() {
tempCelsius = analogRead(sensorTemp);
if (tempCelsius > 30) {
digitalWrite(buzzer, HIGH);
delay(3000);
digitalWrite(buzzer, LOW);
}
delay(3000);
}
