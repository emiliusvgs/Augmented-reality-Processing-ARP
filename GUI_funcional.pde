
import controlP5.*;

ControlP5 controlP5;
Objecto[] elementos;

Padrao[] listaPattGui;
DropdownList p1, p2, p3, p4, p5, p6, p7, p8;
//Textlabel velocity1, nota, cc;
Textfield octave, r1, r2, r3, r4;
Bang down, up,nM;
Midi ocv2;


int patternChoose = 0;
int midiChoose = 0;
int selectPadrao = 0;
int selectObjecto = 0;
int ocv=3;
String img2;
int fcount;


class Gui {



  String[] patts2;

  Gui(Padrao[] listaPattGui_teste) {

    listaPattGui = listaPattGui_teste;
    int pMenuX=(width-300);
    int pMenuX2=(width-180);
    int pMenuY=(height/6);


    /*

     String lines[] = lerFicheiro("atributos.txt");
     
     elementos = new Objecto[lines.length];
     
     for(int i=0;i<lines.length;i++) {
     String atributos[] = split(lines[i], ",");
     
     elementos[i] = new Objecto(atributos[0]);
     
     float escala = float(atributos[1]);
     elementos[i].setEscala(escala);
     }
     
     */

    controlP5.addSlider("gsThreshold", 0, 255, 100, 5, (height-100), 100, 10).moveTo("global");
    controlP5.addSlider("tolerancia", 0, 1, 0.75, 5, (height-100)+20, 100, 10).moveTo("global");
    controlP5.addBang("Default", 5, (height-100)+40, 10, 10).moveTo("global");
    controlP5.addBang("Save", 50, (height-100)+40, 10, 10).moveTo("global");
    controlP5.addBang("Load", 105, (height-100)+40, 10, 10).moveTo("global");
    controlP5.addBang("fullScreen", 150, (height-100)+40, 10, 10).moveTo("global");
    p1 = controlP5.addDropdownList("padrao", 5, pMenuY+70, 100, 120);
    customize1(p1, patts2);
    p1.moveTo("global");


    //3D
    Toggle b3d = controlP5.addToggle("b3d", true, pMenuX2, pMenuY-20, 20, 20);
    b3d.setLabelVisible(false);
    Textlabel onoff= controlP5.addTextlabel("label", "ON/OFF", pMenuX2+22, pMenuY-9);

    controlP5.addSlider("escala", 0.000, 20.000, 1, pMenuX2, pMenuY+40, 100, 10);    
    controlP5.addSlider("translateX", -30, 30, 0, pMenuX2, pMenuY+80, 100, 10);
    controlP5.addSlider("translateY", -30, 30, 0, pMenuX2, pMenuY+120, 100, 10);
    controlP5.addSlider("translateZ", -30, 30, 0, pMenuX2, pMenuY+160, 100, 10);

    controlP5.addSlider("RotateX", 0, 360, 0, pMenuX2, pMenuY+200, 100, 10);
    controlP5.addSlider("RotateY", 0, 360, 0, pMenuX2, pMenuY+240, 100, 10);
    controlP5.addSlider("RotateZ", 0, 360, 0, pMenuX2, pMenuY+280, 100, 10);

    controlP5.tab("default").activateEvent(true);
    controlP5.tab("default").setLabel("3D");
    p2 = controlP5.addDropdownList("objecto", pMenuX2, pMenuY+20, 100, 120);
    customize2(p2);

//    //som
//    controlP5.addSlider("volume", 0, 255, 100, pMenuX2, pMenuY+40, 100, 10).moveTo("som");    
//    p3 = controlP5.addDropdownList("myList-p3", pMenuX2, pMenuY+20, 100, 120);
//    customize3(p3);
//    p3.moveTo("som");
//    Toggle bSom = controlP5.addToggle("sound", false, pMenuX2, pMenuY-20, 20, 20);
//    bSom.setLabelVisible(false);
//    bSom.moveTo("som");
//    Textlabel onoffS= controlP5.addTextlabel("labelPs", "ON/OFF", pMenuX2+22, pMenuY-9);
//    onoffS.moveTo("som");


    //midi

    Toggle bMidi = controlP5.addToggle("bMidi", false, pMenuX, pMenuY-20, 20, 20);
    bMidi.setLabelVisible(false);
    bMidi.moveTo("midi");
    Textlabel onoffM= controlP5.addTextlabel("labelPM", "ON/OFF", pMenuX+22, pMenuY-9);
    onoffM.moveTo("midi");

    Slider sV = controlP5.addSlider("velocity", 0, 127, 100, pMenuX, pMenuY+60, 100, 10);
    sV.setLabelVisible(false);
    sV.moveTo("midi"); 
    Textlabel velocity1 = controlP5.addTextlabel("label", "Velocity", pMenuX, pMenuY+50);
    velocity1.moveTo("midi");
    /* 
     
     */
    Textlabel nota = controlP5.addTextlabel("label2", "Midi Note", pMenuX, pMenuY+20);
    nota.setControlFont(new ControlFont(createFont("Helvetica", 15), 15));
    nota.moveTo("midi");
    p4 = controlP5.addDropdownList("nota", pMenuX+120, pMenuY+71, 50, 100);
    customize4(p4);
    p4.moveTo("midi");
    nM = controlP5.addBang("mapNote", pMenuX+32,pMenuY+90 , 10, 10);
    nM.moveTo("midi");
    

    p8 = controlP5.addDropdownList("channel", pMenuX, pMenuY+100, 30, 60);
    customize8(p8);
    p8.moveTo("midi");


    down = controlP5.addBang("down", pMenuX+190, pMenuY+55, 10, 15);
    down.moveTo("midi");
    down.setLabel("- ");
    octave = controlP5.addTextfield(" oct", pMenuX+210, pMenuY+55, 20, 15);
    octave.moveTo("midi");

    up = controlP5.addBang("up", pMenuX+240, pMenuY+55, 10, 15);
    up.moveTo("midi");
    up.setLabel(" +");

    Textlabel cc= controlP5.addTextlabel("label3", "Midi CC", pMenuX, pMenuY+160);
    cc.setControlFont(new ControlFont(createFont("Helvetica", 15), 15));
    cc.moveTo("midi");


//
//    r1 = controlP5.addTextfield(" R1", pMenuX+190, pMenuY+161, 20, 15);
//    r1.moveTo("midi");        
//    r2 = controlP5.addTextfield(" R2", pMenuX+230, pMenuY+194, 20, 15);
//    r2.moveTo("midi");
//    r3 = controlP5.addTextfield(" R3", pMenuX+190, pMenuY+229, 20, 15);
//    r3.moveTo("midi");
//    r4 = controlP5.addTextfield(" R4", pMenuX+150, pMenuY+194, 20, 15);
//    r4.moveTo("midi");


    /*
    controlP5.addBang("",pMenuX+28,pMenuY+247,8,8).moveTo("midi");
     controlP5.addBang("",28,pMenuY+187,8,8).moveTo("midi");
     controlP5.addBang("",pMenuX+113,pMenuY+187,8,8).moveTo("midi");
     controlP5.addBang("",pMenuX+113,pMenuY+247,8,8).moveTo("midi");
     */

    controlP5.addBang("mapX", pMenuX, pMenuY+210, 8, 8).moveTo("midi");
    controlP5.addBang("mapY", pMenuX+67, pMenuY+210, 8, 8).moveTo("midi");

    p5 = controlP5.addDropdownList("ccX", pMenuX, pMenuY+210, 30, 120);
    customize5(p5);
    p5.moveTo("midi");

    p7 = controlP5.addDropdownList("ccY", pMenuX+67, pMenuY+210, 30, 120);
    customize7(p7);
    p7.moveTo("midi");


    //video
    Toggle bVideo = controlP5.addToggle("bVideo", false, pMenuX2, pMenuY-20, 20, 20);
    bVideo.setLabelVisible(false);
    bVideo.moveTo("video");
    Textlabel onoffV= controlP5.addTextlabel("labelPM", "ON/OFF", pMenuX2+22, pMenuY-9);
    onoffV.moveTo("video");


    controlP5.addSlider("vScale", 0.000, 5.000, 1, pMenuX2, pMenuY+40, 100, 10).moveTo("video");    
    controlP5.addSlider("vTranslateX", -100, 100, 0, pMenuX2, pMenuY+80, 100, 10).moveTo("video");
    controlP5.addSlider("vTranslateY", -100, 100, 0, pMenuX2, pMenuY+120, 100, 10).moveTo("video");

    p6 = controlP5.addDropdownList("Video", pMenuX2, pMenuY+20, 100, 120);
    customize6(p6);
    p6.moveTo("video");
  }
}

public void Default() {

  controlP5.controller("gsThreshold").setValue(100);
  controlP5.controller("tolerancia").setValue(0.4);
}  
/*
public void Save() {
 
 //Gravar atributos dos menus!!
 data=new Data();
 // Começa a gravar!
 data.beginSave();
 
 data.add("atributos3D"+","+escala+","+translateX+","+translateY+","+translateZ+","+RotateX+","+RotateY+","+RotateZ+","+gsThreshold+","+tolerancia);
 
 
 // data.add(myList-p1);//padrao
 //  data.add(myList-p2);//Obj 3D
 data.add(escala);//escala do obj
 data.add(translateX);//trasnlX Obj
 data.add(translateY);//trasnlY Obj
 data.add(translateZ);//trasnlZ Obj
 data.add(RotateX);//rotX Obj
 data.add(RotateY);//rotY Obj
 data.add(RotateZ);//rotZ Obj
 
 
 
 data.add(gsThreshold);
 data.add(tolerancia);
 
 
 data.endSave(
 
 sketchPath("save" + java.io.File.separator + "atributos.txt"));
 } */

public void Load() {



  // print("NOME:" + elementos[0].nome);

  //Objecto teste = new Objecto();


  //String teste[] = lines[0].split();

  //print("asd");

  /*

   controlP5.controller("escala").setValue(float(lines[1]));
   controlP5.controller("translateX").setValue(int(lines[2]));
   controlP5.controller("translateY").setValue(int(lines[3]));
   controlP5.controller("translateZ").setValue(int(lines[4]));
   controlP5.controller("RotateX").setValue(int(lines[5]));
   controlP5.controller("RotateY").setValue(int(lines[6]));
   controlP5.controller("RotateZ").setValue(int(lines[7]));
   */
}





void customize1(DropdownList ddl, String[] patts2) {
  ddl.setBackgroundColor(color(190));
  ddl.setItemHeight(10);
  ddl.setBarHeight(15);
  ddl.captionLabel().set("patterns");
  ddl.valueLabel().set("");
  ddl.captionLabel().style().marginTop = 3;
  ddl.captionLabel().style().marginLeft = 3;
  ddl.valueLabel().style().marginTop = 3;

  for (int i=0;i<listaPattGui.length; i++) {
    ddl.addItem( listaPattGui[i].getNome(), i);
  }
  ddl.setColorBackground(color(60));
  ddl.setColorActive(color(255, 128));
}

void customize2(DropdownList dd2) {
  dd2.setBackgroundColor(color(190));
  dd2.setItemHeight(10);
  dd2.setBarHeight(15);
  dd2.captionLabel().set("Objecto 3D");
  dd2.captionLabel().style().marginTop = 3;
  dd2.captionLabel().style().marginLeft = 3;
  dd2.valueLabel().style().marginTop = 3;


  for (int i=0;i< numObj;i++) {
    dd2.addItem( "" + xmlCL.getChild(0).getChild(i).getStringAttribute("name"), i);
  }
  dd2.setColorBackground(color(60));
  dd2.setColorActive(color(255, 128));
}



void customize3(DropdownList dd3) {
  dd3.setBackgroundColor(color(190));
  dd3.setItemHeight(10);
  dd3.setBarHeight(15);
  dd3.captionLabel().set("som");
  dd3.captionLabel().style().marginTop = 3;
  dd3.captionLabel().style().marginLeft = 3;
  dd3.valueLabel().style().marginTop = 3;
  /*for(int i=0;i< loadSounds.length;i++) {
   dd3.addItem( "" + loadSounds[i], i);
   }*/
  dd3.setColorBackground(color(60));
  dd3.setColorActive(color(255, 128));
}

void customize4(DropdownList dd4) {
  dd4.setBackgroundColor(color(190));
  dd4.setItemHeight(10);
  dd4.setBarHeight(15);
  dd4.captionLabel().set("nota");
  dd4.captionLabel().style().marginTop = 3;
  dd4.captionLabel().style().marginLeft = 3;
  dd4.valueLabel().style().marginTop = 3;
  for (int i=0;i< arrayNotes.length;i++) {
    dd4.addItem( "" + arrayNotes[i][1], i);
  }
  dd4.setColorBackground(color(60));
  dd4.setColorActive(color(255, 128));
}
void customize5(DropdownList dd5) {
  dd5.setBackgroundColor(color(190));
  dd5.setItemHeight(10);
  dd5.setBarHeight(15);
  dd5.captionLabel().set("ccX");
  dd5.captionLabel().style().marginTop = 3;
  dd5.captionLabel().style().marginLeft = 3;
  dd5.valueLabel().style().marginTop = 3;
  for (int i=0;i<30;i++) {
    dd5.addItem(""+i, i);
  }
  dd5.setColorBackground(color(60));
  dd5.setColorActive(color(255, 128));
}
void customize6(DropdownList dd6) {
  dd6.setBackgroundColor(color(190));
  dd6.setItemHeight(10);
  dd6.setBarHeight(15);
  dd6.captionLabel().set("video");
  dd6.captionLabel().style().marginTop = 3;
  dd6.captionLabel().style().marginLeft = 3;
  dd6.valueLabel().style().marginTop = 3;
  for (int i=0;i<numVideo;i++) {
    dd6.addItem(xmlCL.getChild(1).getChild(i).getStringAttribute("name"), i);
  }
  dd6.setColorBackground(color(60));
  dd6.setColorActive(color(255, 128));
}


void customize7(DropdownList dd7) {
  dd7.setBackgroundColor(color(190));
  dd7.setItemHeight(10);
  dd7.setBarHeight(15);
  dd7.captionLabel().set("ccY");
  dd7.captionLabel().style().marginTop = 3;
  dd7.captionLabel().style().marginLeft = 3;
  dd7.valueLabel().style().marginTop = 3;
  for (int i=0;i<30;i++) {
    dd7.addItem(""+i, i);
  }
  dd7.setColorBackground(color(60));
  dd7.setColorActive(color(255, 128));
}


void customize8(DropdownList dd8) {
  dd8.setBackgroundColor(color(190));
  dd8.setItemHeight(10);
  dd8.setBarHeight(15);
  dd8.captionLabel().set("chan");
  dd8.captionLabel().style().marginTop = 3;
  dd8.captionLabel().style().marginLeft = 3;
  dd8.valueLabel().style().marginTop = 3;
  for (int i=0;i<10;i++) {
    dd8.addItem(""+i, i);
  }
  dd8.setColorBackground(color(60));
  dd8.setColorActive(color(255, 128));
}


void controlEvent(ControlEvent theEvent) {


  if (theEvent.isGroup()) {
    // check if the Event was triggered from a ControlGroup

      if (theEvent.group().name() == "padrao") {
      this.patternChoose = int(theEvent.group().value());
      this.loadConfig(int(theEvent.group().value()));
      this.selectPadrao = int(theEvent.group().value());
    }
    else if (theEvent.group().name() == "objecto") {
      this.listaPatt[this.patternChoose].setObj(int(theEvent.group().value()));
      this.selectObjecto = int(theEvent.group().value());
      println(this.patternChoose + "- " + theEvent.group().value());
    }

    else if (theEvent.group().name() == "nota") {
      //listaPatt.setPitch1(this.listaPatt[int(theEvent.group().value())].getPitch1() ));
      this.listaPatt[this.midiChoose].setPitch1(int(theEvent.group().value()+""));

    }



    else if (theEvent.group().name() == "Video") {
      this.listaPatt[this.patternChoose].setVideo(int(theEvent.group().value()));
      //actualVideo = int(theEvent.group().value());
      println(theEvent.group().value());
    }





    if (theEvent.group().name() == "ccY") {
      controlo.setCCY(int(theEvent.group().value()));
    }

    if (theEvent.group().name() == "ccX") {
      controlo.setCCX(int(theEvent.group().value()));
    }
    if (theEvent.group().name() == "chan") {
      //setChan(int(theEvent.group().value()));
    }
  }
  else if (theEvent.isController()) {

    String controller = theEvent.controller().name();

    //if(controller == "escala")
    //this.listaPatt[this.selectObjecto].setEscala(int(theEvent.controller().value()));
  }

  // println(this.selectPadrao);
}

public void loadConfig(int id) {

  // println(listaPattGui[id].getEscala());

  controlP5.controller("escala").setValue(listaPattGui[id].getEscala());

  String[] img =split(listaPattGui[id].getNome(), ".");

  img2= img[0];
}




public void down() {



  if (ocv>-2)
  {
    ocv = ocv -1;
    ocv2 = new Midi();
    ocv2.setOcv(ocv);
    ocv2.load();

    octave.setText(ocv+"");
  }
}



public void up() {

  if (ocv<5) {
    ocv = ocv +1;
    ocv2 = new Midi();
    ocv2.setOcv(ocv);
    ocv2.load();
    octave.setText(ocv+"");
  }
}  

public void mapY() {

  mapY=true;
}
public void mapX() {
  mapX=true;
}

public void mapNote() {
  
mapNote=true;
}


public void fullScreen() {
  fcount=fcount+1;

  if (fcount%2!=0) {

    fs.enter();
  }
  else {
    fs.leave();
  }
}


public void sound(boolean theFlag) {
  if (theFlag==true) {
    bSom = true;
  } 
  else {
    bSom = false;
  }
}


public void bMidi(boolean theFlag) {
  if (theFlag==true) {
    bMidi = true;
  } 
  else {
    bMidi = false;
  }
}

public void b3d(boolean theFlag) {
  if (theFlag==true) {
    b3d = true;
  } 
  else {
    b3d = false;
  }
}

public void bVideo(boolean theFlag) {
  if (theFlag==true) {
    bVideo = true;
  } 
  else {
    bVideo = false;
  }
}


