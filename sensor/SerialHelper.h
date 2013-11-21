#ifndef _SERIAL_HELPER_H_
#define _SERIAL_HELPER_H_

#include "Arduino.h"

byte readByte();

byte skipUntil(char terminator);
char* readStringUntil(char terminator);
String* readNewStringUntil(char terminator);

byte skipUntil(char terminator1, char terminator2);
char* readStringUntil(char terminator1, char terminator2);
String* readNewStringUntil(char terminator1, char terminator2);

#endif _SERIAL_HELPER_H_