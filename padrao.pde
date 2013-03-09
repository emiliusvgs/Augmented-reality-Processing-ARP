class Padrao {

  String nome = "";
  String obs = "";
  double sizeof = 0;
  float escala = 0;
  int obj = 0;
  int state;
  int video;
  int pitch1;
  int chan;
  int controlX, controlY;
  
  Padrao() {
  }

  void setNome(String nome) {
    this.nome = nome;
  }

  public String getNome() {
    return this.nome;
  }

  void setObs(String obs) {
    this.obs = obs;
  }

  public String getObs() {
    return this.obs;
  }

  public double getSize() {
    return this.sizeof;
  }

  void setSize(double sizeof) {
    this.sizeof = sizeof;
  }

  void setEscala(float escala) {
    this.escala = escala;
  }

  public float getEscala() {
    return this.escala;
  }

  void setObj(int obj) {
    this.obj = obj;
  }

  public int getObj() {
    return this.obj;
  }

  void setState(int state) {
    this.state = state;
  }

  public int getState() {
    return this.state;
  }


  void setVideo(int video) {
    this.video = video;
  }

  public int getVideo() {
    return this.video;
  }
  void setPitch1(int pitch1) {
    this.pitch1 = pitch1;
  }

  public int getPitch1() {
    return this.pitch1;
  }
  
  void setChan(int chan) {
    this.chan = chan;
  }

  public int getChan() {
    return this.chan;
  }
  
   void setControlX(int controlX) {
    this.controlX = controlX;
  }

  public int getControlX() {
    return this.controlX;
  }
  
   void setControlY(int controlY) {
    this.controlY = controlY;
  }

  public int getControlY() {
    return this.controlY;
  }
  
}

