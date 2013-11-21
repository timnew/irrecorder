#include "JsonWriter.h"

JsonWriter::JsonWriter(Stream* stream)
	:stream(stream){
}

JsonWriter& JsonWriter::beginObject(){
	stream->print("{");
	return *this;
}

JsonWriter& JsonWriter::memberName(String name){
	string(name);	
	stream->print(':');
	return *this;
}
JsonWriter& JsonWriter::memberName(char* name){
	string(name);
	stream->print(':');
	return *this;
}

JsonWriter& JsonWriter::separator(){
	stream->print(",");
	return *this;

}
JsonWriter& JsonWriter::endObject(){
	stream->print("}");
	return *this;
}

JsonWriter& JsonWriter::beginArray(){
	stream->print("[");
	return *this;
}
JsonWriter& JsonWriter::endArray(){
	stream->print("]");
	return *this;
}

JsonWriter& JsonWriter::string(char* text){
	stream->print("\"");
	stream->print(text);
	stream->print("\"");
	return *this;
}
JsonWriter& JsonWriter::string(String text){
	stream->print("\"");
	stream->print(text);
	stream->print("\"");
	return *this;
}
	
JsonWriter& JsonWriter::number(int number){
	stream->print(number, DEC);
	return *this;
}
JsonWriter& JsonWriter::number(unsigned int number){
	stream->print(number, DEC);
	return *this;
}
JsonWriter& JsonWriter::number(long number){
	stream->print(number, DEC);
	return *this;
}
JsonWriter& JsonWriter::number(unsigned long number){
	stream->print(number, DEC);
	return *this;
}
JsonWriter& JsonWriter::number(short number){
	stream->print(number, DEC);
	return *this;
}
JsonWriter& JsonWriter::number(unsigned short number){
	stream->print(number, DEC);
	return *this;
}
JsonWriter& JsonWriter::number(byte number){
	stream->print(number, DEC);
	return *this;
}
// JsonWriter& JsonWriter::number(float number){
// 	stream->print(number);
//  return *this;
// }
// JsonWriter& JsonWriter::number(double number){
// 	stream->print(number);
//  return *this;
// }

JsonWriter& JsonWriter::null(){
	stream->print("null");
	return *this;
}

JsonWriter& JsonWriter::boolean(bool value){
	stream->print(value ? "true" : "false");
	return *this;
}