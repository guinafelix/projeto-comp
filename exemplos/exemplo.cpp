#include <Arduino.h>
#include <WiFi.h>

int ledPin, brilho;

String ssid, senha;

void setup() {
Serial.begin(115200);
ledPin = 2;
ssid = "MinhaRedeWiFi";
senha = "MinhaSenhaWiFi";
pinMode(ledPin, OUTPUT);
ledcAttach(ledPin, 5000, 8);
WiFi.begin(ssid.c_str(), senha.c_str());
while (WiFi.status() != WL_CONNECTED) {
delay(500);
Serial.println("Conectando ao WiFi...");
}
Serial.println("Conectado ao WiFi!");

}
void loop() {
brilho = 128;
ledcWrite(ledPin, brilho);
delay(1000);
brilho = 0;
ledcWrite(ledPin, brilho);
delay(1000);
}
