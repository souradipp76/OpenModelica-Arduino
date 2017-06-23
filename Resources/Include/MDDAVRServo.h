/*****Servo Controllers*******/
 //Define two servos
  Servo servo1,servo2;

static inline void* MDD_avr_servo_initialize(int servo_no)
{
  if(servo_no==1)
  {
    servo1.attach(9);
    servo1.write(0);    
  }
  if(servo_no==2)
  {
    servo2.attach(10); 
    servo2.write(0);
  }
  return (void*)servo_no;
}

static inline void MDD_avr_servo_finalize(int servo_no)
{
  if(servo_no==1)
    servo1.detach();
  if(servo_no==2)
    servo2.detach();
}

static inline void MDD_avr_servo_move(void* servo_no,int value)
{
  if((int)servo_no==1)
    servo1.write(value);
  if((int)servo_no==2)
    servo2.write(value);
}