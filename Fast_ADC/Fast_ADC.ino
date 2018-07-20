unsigned long start_time;
unsigned long stop_time;
unsigned long values[23000];

void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);
  
  //REG_ADC_MR = (REG_ADC_MR & 0xFFF0FFFF) | 0x00020000;//sets startup time of ADC

  //The normal adc startup time
  //define ADC_STARTUP_NORM     40
  //The fast adc startup time
  //define ADC_STARTUP_FAST     12
  //adc_init(ADC, SystemCoreClock, ADC_FREQ_MAX, ADC_STARTUP_FAST);


  //REG_ADC_MR = (REG_ADC_MR & 0xFFFFFF0F) | 0x00000080; //enable FREERUN mode
  //analogReadResolution(12);

  ADC->ADC_MR |= 0x80;  //set free running mode on ADC
  ADC->ADC_CHER = 0x80; //enable ADC on pin A0
}

void loop() {
  unsigned int i;

  start_time = micros();
  for (i = 0; i < 23000; i++) {
    while ((ADC->ADC_ISR & 0x80) == 0); // wait for conversion
    values[i] = ADC->ADC_CDR[7]; //get values
  }
  stop_time = micros();

 // Serial.print("Total time: ");
 // Serial.println(stop_time - start_time);
  //Serial.print("Average time per conversion: ");
  //Serial.println((float)(stop_time - start_time) / 70000);

  //Serial.println("Values: ");
  for (i = 0; i < 23000; i++) {
    Serial.println(values[i]);
  }

  delay(5000);
}






