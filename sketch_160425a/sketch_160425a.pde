import processing.net.*;

int lf = 10;    // Linefeed in ASCII
int size = 5;
String myString = null;
String stringValueX, stringValueY;
float r, theta; 
int dividerIndex;
float x, y;

Server myServer;

boolean drawEnabled = true;


void setup() {
  size(400, 400);
  background(255);
  myServer = new Server(this, 5204); 
}

void draw() {
  Client thisClient = myServer.available();
  // If the client is not null, and says something, display what it said
  if (thisClient !=null) {
    String whatClientSaid = thisClient.readString();
    if (whatClientSaid != null) {
      dividerIndex = whatClientSaid.indexOf(',');
      //println(whatClientSaid);
      //println(dividerIndex);
      
      try{
      stringValueX = whatClientSaid.substring(0, dividerIndex);
      stringValueY = whatClientSaid.substring(dividerIndex+1);
      r = float(trim(stringValueX));
      theta = float(trim(stringValueY));
      
      x = cos(radians(theta)) * r;
      y = sin(radians(theta)) * r;
      
      x = map(x, 0, 5, 0, 400);
      y = map(y, -3, 3, 0, 400);
      
      putPixel(int(y), int(x));
      
      //println("(" + x + ", " + y + ")");
      } catch(Exception e) {
        println("Error on: " + whatClientSaid);
      }
    } 
  } 
  
    //getXYZalues(myPort);

  //putPixel(0, 0);
  //putPixel(100, 100);
  //putPixel(400, 400);
}

void putPixel(int x, int y) {
  if (drawEnabled) {
    fill(0, 0, 0);
    ellipse(x, y, size, size);
  }
}

void getXYZalues() {
  //while (myPort.available() > 0) {
  //  myString = myPort.readStringUntil(lf);
  //  if (myString != null) {
  //    //myString = trim(myString);
  //    //value = int(myString);
  //    println(myString);
  //        //dividerIndex = myString.indexOf('|'); //at what position in the string is my divider?
 
  //        //stringValueX = myString.substring(0, dividerIndex); //get value before divider
  //        //stringValueY = myString.substring(dividerIndex+1); //get value after divider
 
  //        //x = int(trim(stringValueX)); //convert the string value into an integer
  //        //y = int(trim(stringValueY)); //convert the string value into an integer
        
  //        //println("(" + x + ", " + y + ")");
  //  }
  //}
}

int value = 0;

void keyPressed() {
  if (keyCode == BACKSPACE) {
    clear();
    background(255);
    //println(keyCode);
  }
  
  if (keyCode == TAB) {
    drawEnabled = !drawEnabled;
  }   
}