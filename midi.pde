import themidibus.*; 

int chan;
int pitch;
int velocity = 127;  
int control1 = 22;
int control2 = 27;
int ocvpitch;
String[][] arrayNotes = new String[12][2];





class Midi {

  String nota = "";
  int pitch;
  int ocv;
  int chan;
  int pitch2= int(pitch);
  int ocvTmp = 0;

  Midi() {
  }



  void load() {

    //midi configs
    XMLElement dataNotes = xmlCL.getChild(3);
    int numNotes = dataNotes.getChildCount();

    for (int i=0;i<arrayNotes.length;i++) {

      XMLElement notes = dataNotes.getChild(i);
      arrayNotes[i][0]=notes.getStringAttribute("pitch");
      arrayNotes[i][1]=notes.getStringAttribute("name");


      //println("pitch = " +  arrayNotes[i][0]);
      //println("note = " +arrayNotes[i][1]);
    }
    //println(getPitch());
    //println(this.getOcv());

    /*
    switch(this.getOcv()) {
     
     
     case -2:
     this.ocvTmp = ocvpitch;
     ocvpitch = this.getPitch()-60;
     myBus.sendNoteOff(channel, this.getOcvTmp(), velocity);
     
     
     break;
     
     case -1: 
     this.ocvTmp = ocvpitch; 
     ocvpitch = this.getPitch()-48;
     
     break;
     
     case 0: 
     this.ocvTmp = ocvpitch; 
     ocvpitch = this.getPitch()-36;
     
     break;
     
     case 1: 
     this.ocvTmp = ocvpitch; 
     ocvpitch = this.getPitch()-24;
     
     break;
     
     case 2: 
     this.ocvTmp = ocvpitch; 
     ocvpitch = this.getPitch()-12;
     
     break;
     case 3:
     this.ocvTmp = ocvpitch; 
     ocvpitch = this.getPitch(); 
     
     break;
     
     case 4: 
     this.ocvTmp = ocvpitch; 
     ocvpitch = this.getPitch()+12;
     
     break;
     
     case 5: 
     this.ocvTmp = ocvpitch; 
     ocvpitch = this.getPitch()+24;
     
     break;
     
     default:
     this.ocvTmp = ocvpitch; 
     ocvpitch = this.getPitch();
     
     break;
     }
     
     
     */
   
      //println(ocvpitch);
      // println(ocvTmp);


     // myBus[1].sendNoteOn(this.getChan(), int(arrayNotes[actualPitch][0]), velocity);
      //println(actualPitch); 
      // myBus.sendNoteOn(channel,ocvpitch, velocity); 
      //myBus.sendNoteOff(channel,ocvTemp, velocity);
      println("isto ser som de Midi!");
    
  }

  void setNota(String nota) {
    this.nota = nota;
  }

  void setPitch(String pitch) {
    this.pitch = int(pitch);
  }

  public String getNota() {
    return this.nota;
  }

  public int getOcvTmp() {
    return this.ocvTmp;
  }


  public int getPitch() {
    return this.pitch;
  }


  void setOcv(int ocv) {
    this.ocv = ocv;
  }

  public int getOcv() {
    return this.ocv;
  }


}
class midiCC {
  int ccX, ccY;


  void setCCY(int ccY) {
    this.ccY = ccY;
  }

  public int getCCY() {
    return this.ccY;
  }
  void setCCX(int ccX) {
    this.ccX = ccX;
  }

  public int getCCX() {
    return this.ccX;
  }


  midiCC() {
  }


  midiCC (int markerX, int markerY) {



  

   

    //println("CC "+"x"+ control1  +"="+ mX);
    //println("CC "+"y"+ control2  +"="+ mY);
  }
}


