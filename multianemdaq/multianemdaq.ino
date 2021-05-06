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

const uint32_t HEAD = 0xff495054;  // 0x49 -> 'I', 0x50 -> 'P', 0x54 -> 'T'
const uint32_t FOOT = 0xff00ff00;

struct DaqFrame{
  uint32_t head;
  uint32_t t;
  uint32_t frame_num;
  uint16_t raw[32];
  uint32_t foot;
};

int AVG;
int FPS;
int PERIOD;
const int FRAME_SIZE = sizeof (DaqFrame);

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

  // initialize SPI interface for MCP3208
  SPISettings settings(ADC_CLK, MSBFIRST, SPI_MODE0);
  spi1.begin(SPI_CLK1, SPI_MISO1, SPI_MOSI1, SPI_CS1);

  // initialize serial
  Serial.begin(115200);

  spi1.beginTransaction(settings);

  AVG = 100;  // # of samples to read before 
  PERIOD = 100;
  FPS = 1;
}



void read_frame(uint16_t* raw16, int32_t avg)
{
  int32_t raw[32];
  uint32_t t1;
  uint32_t t2;

  for (int i = 0; i < TOTAL_CHANS; ++i)
    raw[i] = 0;

  for (int k = 0; k < avg; ++k){
    int *r = raw;
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
  for (int i = 0;  i < TOTAL_CHANS; ++i)
    raw16[i] = raw[i] / avg;
  
}
const int NSAMPLES=10;
int16_t raw16[TOTAL_CHANS];

void loop() {

  // Parse Command

  char cmd; // Command mode '.', '*', '?' or '!'
  char var; // Variable
  int val;
  String s;

  uint32_t t1;
  uint32_t t2;
  uint32_t dt;
  
  DaqFrame frame;
  frame.head = HEAD;
  frame.foot = FOOT;
  
  
  if (Serial.available() > 0)
  {
    cmd = Serial.read();
    if (cmd != '.' && cmd != '*' && cmd != '?' && cmd != '!')
    {
      Serial.print("ERR - Unknown command mode -->");
      Serial.println(cmd);
      delay(50);
      s = Serial.readString();   // Clear the buffer
      return;
    }

    if (cmd == '!') {
      // For now do nothing. It doesn't mean anything here!
    } else if (cmd == '.'){ // Set variable value
      delay(50);
      var = Serial.read();
      if (var == -1){
        Serial.println("ERR - Command expected!");
        delay(50);
        s = Serial.readString();
        return;
      }
      // Read the value  
      delay(50);
      s = Serial.readStringUntil('\n');
      val = s.toInt();
      if (var == 'A'){
        if (val < 1 || val > 1000){
          AVG = 1;
        }else{
          AVG = val;
        }
      } else if (var == 'P'){
        if (val < 10 || val > 1000){
          PERIOD=100;
        } else {
          PERIOD = val;
        }
      } else if (var == 'F'){
        if (val < 1 || val > 30000)
          FPS = 1;
        else
          FPS = val;
      }
      Serial.print(var);
      Serial.println(val);
      
    }else if (cmd == '?'){  // Check the value of a variable
      delay(50);
      var = Serial.read();
      if (var == -1){
        Serial.println("ERR - Command expected!");
        delay(50);
        s = Serial.readString();
        return;
      }
      s = Serial.readStringUntil('\n');
      if (var == 'A')
        Serial.println(AVG);
      else if (var == 'P')
        Serial.println(PERIOD);
      else if (var == 'F')
        Serial.println(FPS);
      else{
        Serial.print("ERR - Unkonw variable -->");
        Serial.println(var);
      }
      
    }else if (cmd == '*'){ // Read the values!!!
      delay(50);
      Serial.readString();
      
      Serial.println("START");
      Serial.println(FPS);
      for (int i = 0; i < FPS; ++i){
        t1 = millis();
        read_frame(frame.raw, AVG);        
        frame.t = t1;
        frame.frame_num = i;
        Serial.write((uint8_t *) &frame, FRAME_SIZE);
        dt = millis()-t1;
        if ( dt < PERIOD){
          delay(PERIOD - dt);
        }
        if (Serial.available() > 0){
          cmd = Serial.read();
          if (cmd=='!'){
            delay(50);
            Serial.println("STOP");
            Serial.println(i);
          }
        }
      }
      Serial.println("END");
            
    }
    
  }
  
 
  return;

}
