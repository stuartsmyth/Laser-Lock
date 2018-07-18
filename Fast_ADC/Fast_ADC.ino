unsigned long start_time;
unsigned long stop_time;
unsigned long values[10000];

void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);
  ADC->ADC_MR |= 0x80;  //set free running mode on ADC
  ADC->ADC_CHER = 0x80; //enable ADC on pin A0
}

void loop() {
  unsigned int i;

  start_time = micros();
  for (i = 0; i < 10000; i++) {
    while ((ADC->ADC_ISR & 0x80) == 0); // wait for conversion
    values[i] = ADC->ADC_CDR[7]; //get values
  }
  stop_time = micros();

  //Serial.print("Total time: ");
  //Serial.println(stop_time - start_time);
  //Serial.print("Average time per conversion: ");
  //Serial.println((float)(stop_time - start_time) / 10000);

  //Serial.println("Values: ");
  for (i = 0; i < 1000; i++) {
    Serial.println(values[i]);
  }

  delay(10000);
}






