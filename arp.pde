import mri.*;
import mri.v3ds.*;     
import java.awt.image.BufferedImage;
import processing.video.*;
import jp.nyatla.nyar4psg.*;
import processing.opengl.*;
import javax.media.opengl.*;
import vitamin.*;
import vitamin.math.*;
import fullscreen.*; 
import ddf.minim.*;
import javax.swing.*;

AudioPlayer[] player;
Minim[] minim;
FullScreen fs; 
PImage img; 
Capture cam;
NyARMultiBoard nya;
V3dsScene[] vscene;
VGL vgl;
Padrao[] listaPatt;
String[] loadObj;
String[] loadSounds;
MidiBus[] myBus; 
Midi[] notasMidi2;
Sound[] sounds2;
Movie[] myMovie;
Video[] videoName;

Sound musica = new Sound();
Midi nota = new Midi();
midiCC controlo = new midiCC();


//VALORES DEFAULT
float p = 0;
int gsThreshold = 100;
float tolerancia = 0.6; //cfThreshold
int count = 0;
float escala=1;
float vScale=1;
int translateX =0;
int translateY =0;
int translateZ =0;
int vTranslateX =0;
int vTranslateY =0;
int RotateX = 0;
int RotateY = 0;
int RotateZ = 0;
int numObj=0;
int numVideo=0;
int actualVideo;

//MIDI parameters
boolean aqui=true;
boolean asd=true;
int actualPitch;
int tempPitch;
int controlX, controlY;
boolean mapX =false;
boolean mapY = false;
boolean mapNote=false;

//activate booleans bottons
boolean bSom = false;
boolean bMidi = false;
boolean b3d = true;
boolean bVideo =false;

//XML element
XMLElement xml;
XMLElement xmlCL;

//Window size varialbls
int w, h;


public String[] getAllPatternNome() {

  String[] returnNome = new String[this.listaPatt.length];

  for (int i=0;i<this.listaPatt.length;i++) {
    returnNome[i] = "data/patterns/"+this.listaPatt[i].getNome();
  }

  return returnNome;
}

public double[] getAllPatternSize() {

  double[] returnSize = new double[this.listaPatt.length];

  for (int i=0;i<this.listaPatt.length;i++) {
    returnSize[i] = this.listaPatt[i].getSize();
  }

  return returnSize;
}


//SETUP SIZE WINDOW:::::::::::::::::::::::::::::::::::::::::::::::::::::::::
String[] possibilities = {
  "320x240(menu mess)", "640x480 (recomended)", "800x600"
};
String s = (String)JOptionPane.showInputDialog(
frame, 
"Please choose your ARP window resolution ", 
"Choose window size", 
JOptionPane.WARNING_MESSAGE, 
null, 
possibilities, 
"640x480 (recomended)");


//SETIUP
void setup() {

  //define window size
  if (s=="320x240(menu mess)") {
    w = 320;
    h = 240;
  }
  if (s=="640x480 (recomended)") {
    w = 640;
    h = 480;
  }
  if (s=="800x600") {
    w = 800;
    h = 600;
  }

  if (s==null) {
    System.exit( 0 );
  }

  //PROPRIEDADES
  size(w, h, OPENGL);
  xml = new XMLElement(this, "data/configurations/dataPatterns.xml");
  xmlCL = new XMLElement(this, "data/configurations/contentLoader.xml");

  fs = new FullScreen(this); 
  //fs.setShortcutsEnabled(true);

  hint( ENABLE_OPENGL_4X_SMOOTH );
  smooth();
  colorMode(RGB, 100);
  vgl = new VGL( this );


  //load Videos
  XMLElement video = xmlCL.getChild(1);
  numVideo = video.getChildCount();

  myMovie = new Movie[numVideo];

  for (int i=0;i<numVideo;i++) {
    XMLElement videoName = video.getChild(i);

    String name =videoName.getStringAttribute("name"); 
    myMovie[i] = new Movie(this, "data/videos/"+name);
  }



  // Loading prog= new Loading();
  println("LOADING - THIS MAY TAKE A WHILE DEPENDINDG ON THE 3D OBJECTS SIZE YOU'RE LOADING");  

  //Iniciate cam capture
  cam =new Capture(this, width, height, 60);
  // cam.settings();



  //iniciate midiBus
  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.
  

  //Load midi content
  XMLElement dataNotes = xmlCL.getChild(3);
  int numNotes = dataNotes.getChildCount();
  myBus= new MidiBus[numNotes];
  notasMidi2 = new Midi[numNotes];

  for (int i=0;i<numNotes;i++) {
    XMLElement notes = dataNotes.getChild(i);

    String name =notes.getStringAttribute("name"); 
    String pitch =notes.getStringAttribute("pitch");
    // myBus[i] = new MidiBus(this, 0, 0); // Create a new MidiBus object



    notasMidi2[i]= new Midi();
    //notasMidi2[i].setNota(name);
    //notasMidi2[i].setPitch(pitch);
    notasMidi2[i].load();
  }


  //Load patterns setups
  int numPatterns = xml.getChildCount();
  listaPatt = new Padrao[numPatterns];

  for (int i=0;i<numPatterns;i++) {
    XMLElement dataPatt = xml.getChild(i);

    myBus[i] = new MidiBus(this, 0, 0); // Create a new MidiBus object

    listaPatt[i] = new Padrao();
    listaPatt[i].setNome(dataPatt.getStringAttribute("name"));
    listaPatt[i].setSize(int(dataPatt.getStringAttribute("size")));
    //listaPatt[i].setObs(atributos[1]);
    listaPatt[i].setState(int(dataPatt.getChild(0).getContent()));
    listaPatt[i].setObj(int(dataPatt.getChild(1).getContent()));
    listaPatt[i].setEscala(float(dataPatt.getChild(2).getContent()));
    //video
    listaPatt[i].setVideo(int(dataPatt.getChild(20).getContent()));
    //midi
    listaPatt[i].setPitch1(int(dataPatt.getChild(13).getContent()));
    listaPatt[i].setChan(int(dataPatt.getChild(15).getContent()));
    listaPatt[i].setControlX(int(dataPatt.getChild(17).getContent()));
    listaPatt[i].setControlY(int(dataPatt.getChild(18).getContent()));
    //tempPitch=listaPatt[i].getPitch1();
  }



  // Iniciar o NyARMultiBoard
  //camera_para.dat-> CAM CALIBRATION FILE
  nya=new NyARMultiBoard(this, width, height, "data/camera_para/camera_para.dat", getAllPatternNome(), getAllPatternSize());
 print(nya.VERSION);

  nya.gsThreshold=120;//(0<n<255) default=110
  nya.cfThreshold=0.4;//(0.0<n<1.0) default=0.4

  //LOAD 3DOBJETCS
  XMLElement objName = xmlCL.getChild(0);
  numObj = objName.getChildCount();
  try
  {
    vscene = new V3dsScene[numObj];

    for (int i=0; i<numObj; i++) {

      XMLElement name2 = objName.getChild(i);
      String name ="3dObjects/"+name2.getStringAttribute("name");


      vscene[i] = new V3dsScene(this, name);
      vscene[i].useMaterial( true );
    }
  } 
  catch( Exception e )
  {
    println( e );
  }

  //LOAD MUSIC
  /*loadSounds = lerFicheiro("sounds.txt");
   
   // minim= new player[loadSounds.length];
   minim = new Minim[loadSounds.length];
   for(int i=0; i<loadSounds.length; i++) {
   //String music = loadSounds[];
   println(loadSounds);
   player[i] = minim.loadFile(loadSounds[i], 2048);
   
   }    */


  //Initiate GUI
  controlP5 = new ControlP5(this); 
  Gui teste= new Gui(listaPatt);

  controlP5.hide();
}

public void drawMarkerPos(int[][] pos2d) {
 /* if(bMidi){ 
   
   stroke(100,0,0);
   fill(100,0,0);
   
   // draw ellipses at outside corners of marker
   for(int i=0;i<4;i++){
      hint(ENABLE_DEPTH_TEST);
   ellipse(pos2d[i][0], pos2d[i][1],5,5);
    hint(DISABLE_DEPTH_TEST);
   }
   
   fill(0,0,0);
   for(int i=0;i<4;i++){
      hint(ENABLE_DEPTH_TEST);
   text("("+pos2d[i][0]+","+pos2d[i][1]+")",pos2d[i][0],pos2d[i][1]);
    hint(DISABLE_DEPTH_TEST);
   }
   
   }*/
}


//INITIATE THE DRAW LOOP
void draw() {

  
  nya.gsThreshold=gsThreshold;//(0<n<255) default=110           pouca luz-> 10     +luz  ->120
  // a marker has to be detected with a confidence greater than
  // this threshold for it to be considered a true detection
  nya.cfThreshold=tolerancia;//(0.0<n<1.0) default=0.1
  //nya.lostDelay=10;

  // Verificar camera
  if (cam.available() !=true) 
    return;

  // capturar imagem da camera
  cam.read();

  // need to put camera image on screen, so temporarily disable depth testing
  hint(DISABLE_DEPTH_TEST);
  // put webcam image on screen
  image(cam, 0, 0);

  //if press 'm' -----> menu
  if ((count%2)==0) {

    // hint(DISABLE_DEPTH_TEST);

    // DEFAULT MENU SETUP
    textMode(SCREEN);
    fill(10, 10, 10, 50);
    rect(0, 0, width, height);
    fill(100, 100, 0);  
    PImage b;
    String icon =this.getImg2();
    if (icon!=null) { 
      try
      {
        b = loadImage("data/gif/"+ this.getImg2() +".gif");
        b.resize(100, 100);
        image(b, 5, 30);
      }
      catch( Exception e )
      {
        println( "Plese insert a .gif with your pattern name in data/gif so you can preview it");
        b = loadImage("data/gif/noPatt.gif");
        b.resize(100, 100);
        image(b, 5, 30);
      }
    }
    else {

      b = loadImage("data/gif/noPatt.gif");
      b.resize(100, 100);
      image(b, 5, 30);
    }
    text("frame rate = " + frameRate, 5, height-10);
    textMode(MODEL);   

    controlP5.show();
    hint(ENABLE_DEPTH_TEST);
  }

  else {
    controlP5.hide();
    hint(ENABLE_DEPTH_TEST);
  }




  // if patterns detected...
  if (nya.detect(cam)) {

   
hint(DISABLE_DEPTH_TEST);
    controlP5.draw();

    
    
    for (int i=0; i < nya.markers.length; i++) {

      //deteçao dos padroes
      if (nya.markers[i].detected) {
        
       
        drawMarkerPos(nya.markers[i].pos2d);


        

        if(aqui == true || actualPitch != listaPatt[i].getPitch1()){
        //midi send notes
        
         if (bMidi==true) { 
  

        actualPitch=listaPatt[i].getPitch1();
        myBus[i].sendNoteOn(listaPatt[i].getChan(), int(arrayNotes[actualPitch][0]), velocity);
        
         }
        
        
        }
       aqui=false;
 
    
        //mapButtons
        if(mapX==true){
        myBus[i].sendControllerChange(listaPatt[i].getChan(), listaPatt[i].getControlX(), 0);
        println(listaPatt[i].getControlX());
        controlX=listaPatt[i].getControlX();
       // delay(100);        
        mapX=false;  
    }
    
        if(mapY==true){
          
        myBus[i].sendControllerChange(listaPatt[i].getChan(), listaPatt[i].getControlY(), 0);
        println(listaPatt[i].getControlY());
        controlY=listaPatt[i].getControlY();
      
        mapY=false;  
    }
    
        if(mapNote==true){
          
        myBus[i].sendNoteOn(listaPatt[i].getChan(), int(arrayNotes[listaPatt[i].getPitch1()][0]), velocity);
        myBus[i].sendNoteOff(listaPatt[i].getChan(), int(arrayNotes[listaPatt[i].getPitch1()][0]), velocity);

        mapNote=false; 
  }
  
  
 
        //pattern position.........................
        int markerX = (nya.markers[i].pos2d[0][0]);
        int markerY = (nya.markers[i].pos2d[0][1]);
        int mX = int(map(markerX, 100, 640, 0, 127));
        int mY = int(map(markerY, 100, 480, 0, 127));
        //send midi CC's..
        if (bMidi==true) {
     
        myBus[i].sendControllerChange(listaPatt[i].getChan(), listaPatt[i].getControlX(), mX);
     
     
    

        myBus[i].sendControllerChange(listaPatt[i].getChan(), listaPatt[i].getControlY(), mY);
 
  /* hint(DISABLE_DEPTH_TEST);
     textMode(MODEL);
     fill(255,255,255);
      text("Note: "+arrayNotes[listaPatt[i].getPitch1()][1] ,markerX+10, markerY);
      text("X-CC"+listaPatt[i].getControlX()+"->" +mX,markerX+10, markerY+20);
      text("Y-CC"+listaPatt[i].getControlY()+"->" +mY,markerX+10, markerY+40);
      */
      }

        // depth test back on, we're going to draw 3D YEAH!!
        hint(ENABLE_DEPTH_TEST);


        // videos's on play with it!!!!!
        if (bVideo==true) {
          rotateY(radians(180));
          image(myMovie[listaPatt[i].getVideo()], vTranslateX-80, vTranslateY-60, myMovie[listaPatt[i].getVideo()].width*vScale, myMovie[listaPatt[i].getVideo()].height*vScale);
          myMovie[listaPatt[i].getVideo()].loop();
          myMovie[listaPatt[i].getVideo()].play();
          actualVideo=listaPatt[i].getVideo();
          rotateY(radians(-180));
        }
        

        if (asd == true) {
          // midi's on play with it!!!!!
          if (bMidi==true) { 
            nota.load();
          }
          // sound's on play with it!!!!!
          if (bSom==true) {
            player[2].play();
          }
          asd=false;
        }

        midiCC CC = new midiCC(markerX, markerY);        


        //println(listaPatt[i].getObs());
        pushMatrix();
        translate(0, 0, 5);
        rotateX(radians(45));
        //Objectos 3D.............................................................
        vgl.begin();
        //3dObject Ilumination
        setupLight( new Vector3(10, 510, 400), 1 ); 
        // render scene
        vgl.gl().glMaterialfv( GL.GL_FRONT_AND_BACK, GL.GL_DIFFUSE, new float[] {
          1, 0, 0, 1
        }
        , 0 ); 
        
        //This will afect all 3Dobjects
        translate(translateX,translateY,translateZ);
        rotateX(radians(RotateX));
        rotateY(radians(RotateY));
        rotateZ(radians(RotateZ));
        scale(escala);

        // 3D's on play with it!!!!
        if (b3d==true) {
          vscene[listaPatt[i].getObj()].draw();
        }

        String qwerty = listaPatt[i].getNome();

        vgl.end();

        popMatrix();

      }
    }
    hint(ENABLE_DEPTH_TEST);
    //END FOR
  }
  else if (aqui==false) {

    // println(nota.getOcvTmp());

    
    if (bSom==true) {
      // player[2].close();
    }
    //IF PATTERN OUT CUT/TURN OFF THE NOTE
    for (int i=0;i<listaPatt.length;i++) {
      myBus[i].sendNoteOff(listaPatt[i].getChan(), int(arrayNotes[listaPatt[i].getPitch1()][0]), velocity);
      aqui=true;
  }

     //IF PATTERN OUT CUT/TURN OFF VIDEO
    myMovie[actualVideo].stop();

    //myBus.sendNoteOff(channel, nota.getOcvTmp(), velocity);

  }
}

public void stop() {
  // minim.stop();
  super.stop();
}


//3D ILUMINATION
//val is 0 or 1. 0 = directional light, 1 = point light
void setupLight( Vector3 pos, float val ) {
  GL g = vgl.gl();

  float[] light_emissive = {
    0.0f, 0.0f, 0.0f, 1
  };
  float[] light_ambient = {
    0.10f, 0.10f, 0.10f, 0
  };
  float[] light_diffuse = {
    1.0f, 1.0f, 1.0f, 1.0f
  };
  float[] light_specular = {
    1.0f, 1.0f, 1.0f, 1.0f
  };  
  float[] light_position = {
    pos.x, pos.y, pos.z, val
  };  

  g.glLightfv ( GL.GL_LIGHT1, GL.GL_AMBIENT, light_ambient, 0 );
  g.glLightfv ( GL.GL_LIGHT1, GL.GL_DIFFUSE, light_diffuse, 0 );
  g.glLightfv ( GL.GL_LIGHT1, GL.GL_SPECULAR, light_specular, 0 );
  g.glLightfv ( GL.GL_LIGHT1, GL.GL_POSITION, light_position, 0 );  
  g.glEnable( GL.GL_LIGHT1 );
  g.glEnable( GL.GL_LIGHTING );
  g.glEnable( GL.GL_COLOR_MATERIAL );
}  

void keyPressed() {

  if (keyPressed) {

    if (key == 'm' || key == 'M') {
      count= count +1;
    }
  }
}


void setImg2(String img2) {
  this.img2 = img2;
}

public String getImg2() {
  return this.img2;
}

