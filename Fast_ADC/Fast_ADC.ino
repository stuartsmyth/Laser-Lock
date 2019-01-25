unsigned long start_time;
unsigned long stop_time;
unsigned long values[23000];

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);

  
  ADC->ADC_MR |= 0x80;  //set free running mode on ADC
  ADC->ADC_CHER = 0x80; //enable ADC on pin A0
}

void loop() {
  unsigned int i;

  start_time = micros();
  for (i = 0; i < 23000; i++) {
    while ((ADC->ADC_ISR & 0x80) == 0); // wait for conversion
    values[i] = ADC->ADC_CDR[7]; //get values
    delayMicroseconds(5);
  }
  stop_time = micros();

 Serial.print("Total time: ");
 Serial.println(stop_time - start_time);
 Serial.print("Average time per conversion: ");
 Serial.println((float)(stop_time - start_time) / 23000);

  Serial.println("Values: ");
  for (i = 0; i < 23000; i++) {
    Serial.println(values[i]);
  }

  delay(10000);  // 20 sec delay between loops
}
