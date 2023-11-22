
#ifndef __ESPMCPDAQ_H__
#define __ESPMCPDAQ_H__

#include <Arduino.h>

#include <SPI.h>
#include <Mcp320x.h>

struct DaqFrame{
  uint32_t head;
  uint32_t t;
  uint32_t frame_num;
  uint16_t raw[32];
  uint32_t foot;
};

const int FRAME_SIZE = sizeof (DaqFrame);
      
const MCP3208::Channel chan_id[] = {MCP3208::Channel::SINGLE_0,
				    MCP3208::Channel::SINGLE_1,
				    MCP3208::Channel::SINGLE_2,
				    MCP3208::Channel::SINGLE_3,
				    MCP3208::Channel::SINGLE_4,
				    MCP3208::Channel::SINGLE_5,
				    MCP3208::Channel::SINGLE_6,
				    MCP3208::Channel::SINGLE_7};


template <typename Comm>
class ESPDaq
{
 protected:
  Comm *_comm;  // Handles communication with computer
  
  MCP3208 *_adc[4]; ///< MCP3208 devices
  
  uint32_t _avg;
  uint32_t _period;
  uint32_t _fps;
  DaqFrame _frame;
  
 public:
  ESPDaq(MCP3208 *adc0, MCP3208 *adc1, MCP3208 *adc2, MCP3208 *adc3)
  {
    _adc[0] = adc0; _adc[1] = adc1; _adc[2] = adc2; _adc[3] = adc3;
    _avg = 100;
    _period = 100;
    _fps = 1;
    _comm = 0;
    _frame.head = 0xff495054;
    _frame.foot = 0xff00ff00;
    
  }

  Comm *comm(){ return _comm; }
  void comm(Comm *comm){ _comm = comm; }
  
  
  uint32_t avg(){ return _avg; }
  uint32_t fps(){ return _fps; }
  uint32_t period(){ return _period; }
  
  uint32_t avg(uint32_t x){
    _avg = constrain(x, 1, 1000);
    return _avg;
  }
    
  uint32_t fps(uint32_t x){
    _fps = constrain(x, 1, 60000);
    return _fps;
  }
  uint32_t period(uint32_t x){
    _period = constrain(x, 10, 1000);
    return _period;
  }
  
  
  void read_frame(uint16_t *raw16){
    int32_t raw[32];
    
    for (uint8_t i = 0; i < 32; ++i)
      raw[i] = 0;
    
    for (uint16_t k = 0; k < _avg; ++k)
      {
	int *r = raw;
	for (uint8_t iadc = 0; iadc < 4; ++iadc)
	  {
	    for (int i = 0; i < 8; ++i)
	      {
		*r++ += _adc[iadc]->read(chan_id[i]);
	      }
	  }
      }
    for (int i = 0;  i < 32; ++i)
      raw16[i] = raw[i] / _avg;
    
  }
  
  void acquire()
  {
    uint32_t t1;
    uint32_t t2;
    uint32_t dt;
    uint16_t *raw = _frame.raw;
    char cmd;
    
    for (uint32_t i = 0; i < _fps; ++i)
      {
	t1 = millis();
	read_frame(raw);
	_frame.t = t1;
	_frame.frame_num = i;
	_comm->write( (uint8_t *) &_frame, FRAME_SIZE);
	dt = millis() - t1;
	if (dt < _period)
	  {
	    delay(_period - dt);
	  }
	
	if (_comm->available() > 0)
	  {
	    cmd = _comm->read();
	    if (cmd == '!')
	      {
		delay(50);
		_comm->println("STOP");
		_comm->println("i");
	      }
	  }
      }
 }

  void repl()
  {
    char cmd;
    String s;
    char var;
    int val;
    
    if (_comm->available() > 0)
      {
	cmd = _comm->read();
	if (cmd != '.' && cmd != '*' && cmd != '?' && cmd != '!')
	  {
	    _comm->print("ERR - Unknown command mode -->");
	    _comm->println(cmd);
	    delay(50);
	    s = _comm->readString();   // Clear the buffer
	    return;
	  }

	if (cmd == '!') {
	  // For now do nothing. It doesn't mean anything here!
	} else if (cmd == '.'){ // Set variable value
	  delay(50);
	  var = _comm->read();
	  if (var == -1){
	    _comm->println("ERR - Command expected!");
	    delay(50);
	    s = _comm->readString();
	    return;
	  }
	  // Read the value  
	  delay(50);
	  s = _comm->readStringUntil('\n');
	  val = s.toInt();
	  if (var == 'A'){
	    avg(val);
	  } else if (var == 'P'){
	    period(val);
	  } else if (var == 'F'){
	    fps(val);
	  }
	  _comm->print(var);
	  _comm->println(val);

	}else if (cmd == '?'){  // Check the value of a variable
	  delay(50);
	  var = _comm->read();
	  if (var == -1){
	    _comm->println("ERR - Command expected!");
	    delay(50);
	    s = _comm->readString();
	    return;
	  }
	  s = _comm->readStringUntil('\n');
	  if (var == 'A')
	    _comm->println(avg());
	  else if (var == 'P')
	    _comm->println(period());
	  else if (var == 'F')
	    _comm->println(fps());
	  else{
	    _comm->print("ERR - Unkonw variable -->");
	    _comm->println(var);
	  }
	  
	}else if (cmd == '*'){ // Read the values!!!
	  delay(50);
	  _comm->readString();
	  acquire();
	  
	}
            
      }
    
  }
  
};

#endif //__ESPMCPDAQ_H__

