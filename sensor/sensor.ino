#include "Arduino.h"
#include "IRremote.h" // Library available at https://github.com/shirriff/Arduino-IRremote
#include "SerialHelper.h"
#include "JsonWriter.h"

#define SENSOR_PIN 11

IRrecv irrecv(SENSOR_PIN);
decode_results results;
JsonWriter json(&Serial);

boolean read = false;

void setup()
{
	Serial.begin(9600);
	irrecv.enableIRIn(); 
	read = false;
}

void dump(decode_results *results) {
	int count = results->rawlen;
	json.beginObject().memberName("type");
	
	switch(results->decode_type) {
	 	case UNKNOWN:
			json.string("Unknown"); 
			break;
		case NEC:
			json.string("NEC"); 
			break;
		case SONY:
			json.string("Sony"); 
			break;
		case RC5:
			json.string("RC5"); 
			break;
		case RC6:
			json.string("RC6");
			break;
		case PANASONIC:
			 json.string("Panasonic");
			 break;
		case JVC:
			 json.string("JVC");
			 break;
	}
	json.separator();

	if(results->decode_type == PANASONIC) {
		json
			.memberName("address")
			.number(results->panasonicAddress)
			.separator();		
	}
	
	json
		.memberName("value")
		.number(results->value)
		.separator()
		.memberName("size")
		.number(results->bits)
		.endObject();
}


void loop() {	
	if(Serial.available()) {
		String command = String(readStringUntil('?'));
		
		#ifdef DEBUG
		Serial.println(command);
		#endif		

		if(command == "Sequence?") {
			Serial.println("Sequence");
			irrecv.resume();
			read = true;
		}
		else if(command == "Ready?") {       			
			Serial.println("SENSOR:OK");
		} else {        
			Serial.print("SENSOR:Unknown Command:");
			Serial.println(command);
		}
	}
	
	#ifdef DEBUG
	if(read)
		Serial.println("reading");
	#endif DEBUG

	if (read && irrecv.decode(&results)) {    
		dump(&results);
		read = false;
		irrecv.resume();
	}
}