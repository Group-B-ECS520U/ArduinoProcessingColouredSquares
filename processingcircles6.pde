import processing.serial.*;
Serial myPort;
String val;     // Data received from the serial port
int[] penLocation = {0,0};

void setup() {
  size(900,600); //create sketch background
  background(155,155,155);
  noStroke();
  String portName= "COM3"; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600);
}

void draw(){
  if ( myPort.available() > 0) {  // If data is available,
    val = myPort.readStringUntil('\n');         // read it and store it in val
  } 
  val = trim(val)+"_"; //remove extra elements, and add a _ to the end in order to avoid null pointer errors
  print(val); //print it out in the console
  //println(millis());
  drawBackground();
  getReader(val);
}

void drawBackground(){ //create grid of squares
  fill(255,255,255);
  rect(0,0,300,300);
  rect(0,300,300,300);
  rect(300,0,300,300);
  rect(300,300,300,300);
  rect(600,0,300,300);
  rect(600,300,300,300);

}

void getReader(String val){
  char readerVal = val.charAt(1); //find the second character and set that as the reader number
   if (readerVal == '3'){ //check which reader is being used
      println("zero");
      penLocation[0] = 0; //set location of the selected square
      penLocation[1] = 0;
      getTag(val); //send through val string to find the fill colour associated with the tag ID
      rect(penLocation[0]*300, penLocation[1]*300,450,300); //draw the rectange
   }
   else if (readerVal == '4'){
      println("one");
      penLocation[0] = 1;
      penLocation[1] = 0;
      getTag(val);
      rect(penLocation[0]*450, penLocation[1]*300,450,300);
   }
   else if (readerVal == '0'){
      println("two");
      penLocation[0] = 0;
      penLocation[1] = 1;
      getTag(val);
      rect(penLocation[0]*300, penLocation[1]*300,300,300);
   }
   else if (readerVal == '2'){
      println("three");
      penLocation[0] = 1;
      penLocation[1] = 1;
      getTag(val);
      rect(penLocation[0]*300, penLocation[1]*300,300,300);
   }
   else if (readerVal == '1'){
      println("four");
      penLocation[0] = 2;
      penLocation[1] = 1;
      getTag(val);
      rect(penLocation[0]*300, penLocation[1]*300,300,300);
   }
}

void getTag(String val){ //find the tag id in the read string and set fill colour accordingly
  int exInd = val.indexOf("!"); //find beginning of tag ID
  int commInd = val.indexOf(":"); //find end of tag ID
  String tagID = val.substring(exInd+1, commInd); //find tag ID
  println(tagID);
  
  String[] Tags = {" 33 27 28 11"," 93 9D 91 0D"," E3 26 D4 12"," 43 37 2F 11"}; //array of tagIDs
  int[] TagCol = {255,0,0,0,255,0,0,0,255,255,255,0}; // array of colours for each tagID
  
  for (int i = 0; i< Tags.length;i++){ //find tag ID in the array and set fill colour to coresponding integers from second array
    if (Tags[i].equals(tagID)){
      fill(TagCol[3*i],TagCol[3*i+1],TagCol[3*i+2]);
    }
  }
}
