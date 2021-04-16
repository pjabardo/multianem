# multianem - Multiple channel thermistor based CTA anemometer

This projecto has as its objective implement low cost multiple channel thermistor based constant temperature anemometer systems. This projecto includes the KICAD projects for the sensors and data acquisition system.

The main objective is to design a robust, cheap and easily sourced system. By easily sourced system, I mean that the components should be readily available in Brazil.

The project has different parts:

 * `multiname`: Basic board with 8 sensors.
 * `esp32-daq-board`: Data acquisition system for 32 channels
 * `multianem-box`: 3D printed/CNC casing for the system.
 * `multianemdaq`: embedded data acquisition software for the ESP32
 * Other software: data acquisition for Julia, R and Python (nothing to see yet...)



