import processing.serial.*;
Serial myPort;
String val;     // Data received from the serial port
int[] penLocation = {0,0};

void setup() {
  size(800,600);
  background(155,155,155);
  noStroke();
  String portName= "COM5"; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600);
}

void draw(){
  if ( myPort.available() > 0) {  // If data is available,
    val = myPort.readStringUntil('\n');         // read it and store it in val
  } 
  val = trim(val)+"_";
  print(val); //print it out in the console
  //println(millis());
  drawBackground();
  getReader(val);
}

void drawBackground(){
  fill(255,255,255);
  rect(0,0,200,200);
  rect(0,200,200,200);
  rect(0,400,200,200);
  rect(200,0,200,200);
  rect(200,200,200,200);
  rect(200,400,200,200);
  rect(400,0,200,200);
  rect(400,200,200,200);
  rect(400,400,200,200);
  rect(600,0,200,200);
  rect(600,200,200,200);
  rect(600,400,200,200);
}

void getReader(String val){
  char readerVal = val.charAt(1);
   if (readerVal == '1'){
      println("one");
      penLocation[0] = 2;
      penLocation[1] = 1;
      getTag(val);
   }
   else if (readerVal == '0'){
      println("zero");
      penLocation[0] = 1;
      penLocation[1] = 1;
      getTag(val);
   }
}

void getTag(String val){
  int exInd = val.indexOf("!");
  int commInd = val.indexOf(":");
  String tagID = val.substring(exInd+1, commInd);
  println(tagID);
  
  String[] Tags = {" 33 27 28 11"," 93 9D 91 0D"," E3 26 D4 12"," 43 37 2F 11"};
  int[] TagCol = {255,0,0,0,255,0,0,0,255,255,255,0};
  
  for (int i = 0; i< Tags.length;i++){
    if (Tags[i].equals(tagID)){
      fill(TagCol[3*i],TagCol[3*i+1],TagCol[3*i+2]);
    }
  }
  rect(penLocation[0]*200, penLocation[1]*200,200,200);
}
