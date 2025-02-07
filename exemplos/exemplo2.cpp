#include <Arduino.h>
#include <WiFi.h>

int temperatura;

String nomeDispositivo;

void setup() {
temperatura = 60;
umidade = Serial.readString();
Serial.begin(115200);
Serial.println("Configuracao de serial realizada");
nomeDispositivo = "SensorExterno";
localizacao = "Jardim";
pinMode(temperatura, INPUT);
pinMode(umidade, INPUT);
pinMode(nomeDispositivo, OUTPUT);
pinMode(localizacao, OUTPUT);
WiFi.begin(nomeDispositivo.c_str(), localizacao.c_str());
while (WiFi.status() != WL_CONNECTED) {
delay(500);
Serial.println("Conectando ao WiFi...");
}
Serial.println("Conectado ao WiFi!");

}
void loop() {
temperatura = analogRead(temperatura);
umidade = analogRead(umidade);
delay(2000);
if (temperatura > 30) {
digitalWrite(nomeDispositivo, HIGH);
} else {
digitalWrite(nomeDispositivo, LOW);
}
delay(5000);
}
