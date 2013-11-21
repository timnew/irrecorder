#ifndef __JSON_WRITER_H__
#define __JSON_WRITER_H__

#include "Arduino.h"

class JsonWriter {
private:
	Stream* stream;

public:
	JsonWriter(Stream* stream);

	JsonWriter& beginObject();	
	JsonWriter& memberName(char* name);	
	JsonWriter& memberName(String name);	
	JsonWriter& separator();
	JsonWriter& endObject();

	JsonWriter& beginArray();
	JsonWriter& endArray();

	JsonWriter& string(char* text);
	JsonWriter& string(String text);
	
	JsonWriter& number(int number);
	JsonWriter& number(unsigned int number);
	JsonWriter& number(long number);
	JsonWriter& number(unsigned long number);
	JsonWriter& number(short number);
	JsonWriter& number(unsigned short number);
	JsonWriter& number(byte number);
	// JsonWriter& number(float number);
	// JsonWriter& number(double number);

	JsonWriter& null();

	JsonWriter& boolean(bool value);
};

#endif __JSON_WRITER_H__
