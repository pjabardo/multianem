/**
 * Basic ADC reading example.
 * - connects to ADC
 * - reads value from channel
 * - converts value to analog voltage
 */

#include <SPI.h>
#include <Mcp320x.h>

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

const MCP3208::Channel chan_id[] = {MCP3208::Channel::SINGLE_0, MCP3208::Channel::SINGLE_1, MCP3208::Channel::SINGLE_2, MCP3208::Channel::SINGLE_3,
                           MCP3208::Channel::SINGLE_4, MCP3208::Channel::SINGLE_5, MCP3208::Channel::SINGLE_6, MCP3208::Channel::SINGLE_7};
                           


SPIClass spi1(VSPI);

MCP3208 adc1(ADC_VREF, SPI_CS1, &spi1);
MCP3208 adc2(ADC_VREF, SPI_CS2, &spi1);
MCP3208 adc3(ADC_VREF, SPI_CS3, &spi1);
MCP3208 adc4(ADC_VREF, SPI_CS4, &spi1);

int raw[TOTAL_CHANS];

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


  // initialize serial
  Serial.begin(115200);


  // initialize SPI interface for MCP3208
  SPISettings settings(ADC_CLK, MSBFIRST, SPI_MODE0);
  spi1.begin(SPI_CLK1, SPI_MISO1, SPI_MOSI1, SPI_CS1);
  
  spi1.beginTransaction(settings);


}



const int NSAMPLES=1;
void loop() {

  uint32_t t1;
  uint32_t t2;
  // start sampling
  Serial.println("Reading...");
  for (int i = 0; i < TOTAL_CHANS; ++i)
    raw[i] = 0;
  
  t1 = micros();
  int *r = raw;
  for (int k = 0; k < NSAMPLES; ++k){
    for (int i = 0; i < 8; ++i)
    {
      *r++ += adc1.read(chan_id[i]);
    }
    for (int i = 0; i < 8; ++i)
    {
      *r++ += adc2.read(chan_id[i]);
    }
    for (int i = 0; i < 8; ++i)
    {
      *r++ += adc3.read(chan_id[i]);
    }
    for (int i = 0; i < 8; ++i)
    {
      *r++ += adc4.read(chan_id[i]);
    }
  }
  t2 = micros();

  // get analog value

  for (int i = 0; i < TOTAL_CHANS; ++i)
  {
    Serial.print(i);
    Serial.print(") ");
    Serial.print(raw[i]/NSAMPLES);
    Serial.print(" -> ");
    Serial.print( (raw[i]*ADC_VREF) / (NSAMPLES * 4095) );
    Serial.println(" mV");
    
  }
  Serial.println("");

  // sampling time
  Serial.print("Sampling time: ");
  Serial.print(static_cast<double>(t2 - t1) / 1000, 4);
  Serial.println("ms");

  delay(1000);
}
