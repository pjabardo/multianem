/**
 * Basic ADC reading example.
 * - connects to ADC
 * - reads value from channel
 * - converts value to analog voltage
 */

#include "espmcpdaq.h"

//#define _USE_SERIAL_
#define _USE_WIFI_

#define SPI_MOSI1   23       
#define SPI_MISO1   19
#define SPI_CLK1    18

#define SPI_CS1      5        // SPI slave select
#define SPI_CS2      22
#define SPI_CS3      25
#define SPI_CS4      26

//#define SPI_MOSI2   13       
//#define SPI_MISO2   12
//#define SPI_CLK2    14

#define ADC_VREF    2500     // 3.3V Vref
#define ADC_CLK     1600000  // SPI clock 1.6MHz

#define NCHANS 8
#define NMCP 4
#define TOTAL_CHANS 32

//const uint32_t HEAD = 0xff495054;  // 0x49 -> 'I', 0x50 -> 'P', 0x54 -> 'T'
//const uint32_t FOOT = 0xff00ff00;


SPIClass spi1(VSPI);

MCP3208 adc1(ADC_VREF, SPI_CS1, &spi1);
MCP3208 adc2(ADC_VREF, SPI_CS2, &spi1);
MCP3208 adc3(ADC_VREF, SPI_CS3, &spi1);
MCP3208 adc4(ADC_VREF, SPI_CS4, &spi1);


#ifdef _USE_SERIAL_
#undef _USE_WIFI_

ESPDaq<HardwareSerial> espdaq(&adc1, &adc2, &adc3, &adc4);

#endif

#ifdef _USE_WIFI_
#undef _USE_SERIAL_

#include<WiFi.h>
const char *ssid = "tunel";
const char *password = "gvento123";

WiFiServer server(9523);

ESPDaq<WiFiClient> espdaq(&adc1, &adc2, &adc3, &adc4);



void connect_wifi_ap(){
  uint8_t dcnt = 0;
  if (WiFi.status() != WL_CONNECTED){
    
    Serial.println("\nConnecting");
    while (WiFi.status() != WL_CONNECTED){
      Serial.print(".");
      delay(500);
      dcnt++;
      if (dcnt % 30 == 0){
        dcnt = 0;
        Serial.println("");
      }
          
    }
    Serial.print("ESP32 IP: ");
    Serial.println(WiFi.localIP());
    server.begin();
  }
    
}

#endif

void setup() {
  // configure PIN mode
  pinMode(SPI_CS1, OUTPUT);
  pinMode(SPI_CS2, OUTPUT);
  pinMode(SPI_CS3, OUTPUT);
  pinMode(SPI_CS4, OUTPUT);

  digitalWrite(SPI_CS1, HIGH);
  digitalWrite(SPI_CS2, HIGH);
  digitalWrite(SPI_CS3, HIGH);
  digitalWrite(SPI_CS4, HIGH);

  // initialize SPI interface for MCP3208
  SPISettings settings(ADC_CLK, MSBFIRST, SPI_MODE0);
  spi1.begin(SPI_CLK1, SPI_MISO1, SPI_MOSI1, SPI_CS1);
  spi1.beginTransaction(settings);

  // We will use serial communications in any case. 
  // In WiFi, just jo get the IP number in the local network
  Serial.begin(115200);  

#ifdef _USE_SERIAL_
  // initialize serial
  espdaq.comm(&Serial);
#endif

#ifdef _USE_WIFI_
  Serial.println("Attempting to connect");
   WiFi.begin(ssid, password);
  connect_wifi_ap();
  espdaq.comm(0);
#endif


}



void loop() {

#ifdef _USE_WIFI_
  // Check if we still have wifi connection to the access point
  connect_wifi_ap();
  WiFiClient client = server.available();
  delay(100);
  if (client){
    client.setTimeout(1);
    Serial.println("Client connected!");
    espdaq.comm(&client);
    while (client.connected()){
      espdaq.repl();
    }
  }
  
#else
  
  // Parse Command
  espdaq.repl();
#endif

  return;

}
