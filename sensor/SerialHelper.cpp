#include "SerialHelper.h"

#define BUFFER_SIZE 256
char buffer[BUFFER_SIZE];
int size = 0;

byte readByte() {
	int data;
	while((data = Serial.read()) == -1) ;
	return (byte)data;
}

byte skipUntil(char terminator) {
	size = Serial.readBytesUntil(terminator, buffer, BUFFER_SIZE);

	return size;
}

char* readStringUntil(char terminator) {
	skipUntil(terminator);
	buffer[size] = 0;
	return buffer;
}

String* readNewStringUntil(char terminator) {
	readStringUntil(terminator);
	return new String(buffer);
}

byte skipUntil(char terminator1, char terminator2) {	
	for(size = 0; size < BUFFER_SIZE; size++)
		buffer[size] = 0;

	for(size = 0; size < BUFFER_SIZE; size++) {
		buffer[size] = (char)readByte();
				
		if(buffer[size] == terminator1 || buffer[size] == terminator2) {
			size++;
			break;
		}		
	}

	return size;
}

char* readStringUntil(char terminator1, char terminator2) {	
	skipUntil(terminator1, terminator2);
	buffer[size] = 0;
	return buffer;
}

String* readNewStringUntil(char terminator1, char terminator2) {
	readStringUntil(terminator1, terminator2);
	return new String(buffer);
}

