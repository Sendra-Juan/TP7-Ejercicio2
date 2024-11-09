import processing.serial.*;
Serial myPort;

boolean StateButton1 = false;
boolean StateButton2 = false;
boolean StateLed1 = false;
boolean StateLed2 = false;

void setup() {
  size(400, 200);
  String portName = Serial.list()[3]; // Selecciona el primer puerto (ajústalo según tu conexión)
  myPort = new Serial(this, portName, 9600);
  myPort.bufferUntil('\n'); // Leer hasta nueva línea
}

void draw() {
  background(255);

  // Dibujar botones y LEDs
  fill(StateButton1 ? color(0, 255, 0) : color(255, 0, 0)); // Verde si el botón está presionado
  rect(50, 50, 100, 50);
  fill(StateButton2 ? color(0, 255, 0) : color(255, 0, 0));
  rect(50, 120, 100, 50);

  fill(StateLed1 ? color(0, 0, 255) : color(100)); // Azul si el LED está encendido
  rect(250, 50, 100, 50);
  fill(StateLed2 ? color(0, 0, 255) : color(100));
  rect(250, 120, 100, 50);

  // Etiquetas de texto
  fill(0);
  textAlign(CENTER, CENTER);
  text("Button 1", 100, 75);
  text("Button 2", 100, 145);
  text("LED 1", 300, 75);
  text("LED 2", 300, 145);
}

void mousePressed() {
  // Verificar si se hizo clic en el área de los LEDs para alternar el estado
  if (mouseX > 250 && mouseX < 350 && mouseY > 50 && mouseY < 100) {
    myPort.write('1'); // Comando para alternar LED 1
  } else if (mouseX > 250 && mouseX < 350 && mouseY > 120 && mouseY < 170) {
    myPort.write('2'); // Comando para alternar LED 2
  }
}

void serialEvent(Serial myPort) {
  String data = myPort.readStringUntil('\n');
  if (data != null) {
    data = trim(data);
    String[] values = split(data, ',');
    if (values.length == 4) {
      StateButton1 = values[0].charAt(3) == '1'; // B1:1 o B1:0
      StateButton2 = values[1].charAt(3) == '1';
      StateLed1 = values[2].charAt(3) == '1';
      StateLed2 = values[3].charAt(3) == '1';
    }
  }
}
