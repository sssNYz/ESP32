#include <WiFi.h>
#include <PubSubClient.h>

#define MQTT_SERVER   "d0529800-2eca-11ef-bce4-c54c62f3e59a"
#define MQTT_PORT     1883
#define MQTT_USERNAME "LoKSLvn17QkPZKQNFviV"
#define MQTT_PASSWORD "123456"
#define MQTT_NAME     "ESP32_1"

WiFiClient client;
PubSubClient mqtt(client);

const char* ssid = "iPhone sssNy";
const char* password = "s31122546";




void setup() {
Serial.begin(9600);
while (!Serial);

WiFi.begin(ssid, password);

 while (WiFi.status() != WL_CONNECTED) {
   delay(500);
   Serial.println("Connecting to WiFi..");
 }
 
 //Serial.print("IP address : ");
// Serial.println(WiFi.localIP()); 
 Serial.println("IP address: ");
Serial.println(WiFi.localIP());

mqtt.setServer(MQTT_SERVER, MQTT_PORT);
}

void loop() {
  // put your main code here, to run repeatedly:
float volt = random(220.0,240.0);
float current = random(1.0,5.0);

Serial.println("volt = ");
Serial.print(volt);
Serial.print("\t Current = ");
Serial.println(current);

delay(5000);

  if (mqtt.connected() == false) {
    Serial.print("MQTT connection... ");
    if (mqtt.connect(MQTT_NAME, MQTT_USERNAME, MQTT_PASSWORD)) {
      Serial.println("connected");
     
    } else {
      Serial.println("failed");
      delay(5000);
    }
  } else {
    mqtt.loop();
    mqtt.publish("v1/devices/me/telemetry", "(\"data\" : 100 }");
  }
}
