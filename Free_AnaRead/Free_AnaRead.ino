int analogPin = 3;   // set pin number to variable 
unsigned long val[20000];      // intialise value to be read in as zero
unsigned long start_time;
unsigned long stop_time;

void setup() {
  // put your setup code here, to run once:
Serial.begin(112500); //setup serial port at given 
REG_ADC_MR = (REG_ADC_MR & 0xFFFFFF0F) | 0x00000080; //enable FREERUN mode
analogReadResolution(12);
}

void loop() {
  unsigned int i;

  start_time = micros();
  for (i = 0; i<20000; i++) {
val[i] = analogRead(analogPin);
delayMicroseconds(2);
  }
  stop_time = micros();

  Serial.print("Total time: ");
  Serial.println(stop_time - start_time);
  Serial.print("Average time per conversion: ");
  Serial.println((float)(stop_time - start_time) / 20000);
  
  Serial.println("Values: ");
  for (i = 0; i < 20000; i++) {
    Serial.println(val[i]);
  }

   delay(5000);
}
