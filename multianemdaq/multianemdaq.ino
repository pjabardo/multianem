/**
 * Basic ADC reading example.
 * - connects to ADC
 * - reads value from channel
 * - converts value to analog voltage
 */

#include "espmcpdaq.h"

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

#define _USE_SERIAL_
//#define _USE_WIFI_

#ifdef _USE_SERIAL_
#undef _USE_WIFI_

ESPDaq<HardwareSerial> espdaq(&adc1, &adc2, &adc3, &adc4);

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

#ifdef _USE_SERIAL_
  // initialize serial
  Serial.begin(115200);
  espdaq.comm(&Serial);
#endif

  spi1.beginTransaction(settings);

}




void loop() {

  // Parse Command
  espdaq.repl();
 
  return;

}
