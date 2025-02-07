#include <Arduino.h>
#include <WiFi.h>

int temperatura, umidade, botao, estadoBotao;

String nomeDispositivo, senha;

void setup() {
temperatura = 60;
umidade = Serial.readString();
Serial.begin(115200);
Serial.println("Configuracao de serial realizada");
nomeDispositivo = "SensorExterno";
senha = "Jardim";
pinMode(temperatura, INPUT);
pinMode(umidade, INPUT);
pinMode(botao, INPUT);
estadoBotao = digitalRead(botao);
pinMode(nomeDispositivo, OUTPUT);
WiFi.begin(nomeDispositivo.c_str(), senha.c_str());
while (WiFi.status() != WL_CONNECTED) {
delay(500);
Serial.println("Conectando ao WiFi...");
}
Serial.println("Conectado ao WiFi!");

HttpClient http;
http.begin("http://example.com");
http.addHeader("Content-Type", "application/x-www-form-urlencoded");
http.POST("dados=123");
http.end();
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
