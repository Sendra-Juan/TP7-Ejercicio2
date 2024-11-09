#define Led1 3
#define Led2 4
#define Button1 10
#define Button2 11

bool StateLed1 = false;
bool StateLed2 = false;

bool StateOldB1 = true;
bool StateOldB2 = true;

bool StateNewB1;
bool StateNewB2;

void setup() 
{
Serial.begin(9600);
pinMode(Led1, OUTPUT);
pinMode(Led2, OUTPUT);
pinMode(Button1, INPUT_PULLUP);
pinMode(Button2, INPUT_PULLUP);
}

void loop()
{
StateNewB1 = digitalRead(Button1);
StateNewB2 = digitalRead(Button2);

delay(200);

if(StateNewB1 == false && StateOldB1 == true)
  {
    if(StateLed1 == false)
    {
      digitalWrite(Led1, HIGH);
      StateLed1 = true;
    }
    else
    {
      digitalWrite(Led1, LOW);
      StateLed1 = false;
    }
  }
StateOldB1 = StateNewB1;

if(StateNewB2 == false && StateOldB2 == true)
  {
    if(StateLed2 == false)
    {
      digitalWrite(Led2, HIGH);
      StateLed2 = true;
    }
    else
    {
      digitalWrite(Led2, LOW);
      StateLed2 = false;
    }
  }
StateOldB2 = StateNewB2;


Serial.print("B1:");
Serial.print(StateNewB1);
Serial.print(",B2:");
Serial.print(StateNewB2);
Serial.print(",L1:");
Serial.print(StateLed1);
Serial.print(",L2:");
Serial.println(StateLed2);


if (Serial.available() > 0) 
  {
    char command = Serial.read();  // Leer el comando
    if (command == '1') 
      {
        StateLed1 = !StateLed1;      // Alternar LED 1
        digitalWrite(Led1, StateLed1);
      } 
    else if (command == '2') 
      {
        StateLed2 = !StateLed2;      // Alternar LED 2
        digitalWrite(Led2, StateLed2);
      }
  }
}
