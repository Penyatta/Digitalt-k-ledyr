ArrayList<Knap> knapper = new ArrayList<Knap>();

class Knap {
  float x, y, sizeX, sizeY, tekstSize;
  color farve, hoverFarve, klikFarve, tekstFarve;
  String tekst;
  boolean isActive = false;
  Knap(float X, float Y, float SIZEX, float SIZEY, color FARVE, color HOVERFARVE, color KLIKFARVE, String TEKST, float TEKSTSIZE, color TEKSTFARVE) {
    x = X;
    y = Y;
    sizeX = SIZEX;
    sizeY = SIZEY;
    farve = FARVE;
    hoverFarve = HOVERFARVE;
    klikFarve = KLIKFARVE;
    tekst = TEKST;
    tekstSize = TEKSTSIZE;
    tekstFarve = TEKSTFARVE;
    knapper.add(this);
  }
  void tegnKnap() {
    if (musOver()) {
      if (mousePressed) {
        fill(klikFarve);
      } else {
        fill(hoverFarve);
      }
    } else {
      fill(farve);
    }
    rect(x-camX, y-camY, sizeX, sizeY);
    textAlign(CENTER, CENTER);
    textSize(tekstSize);
    fill(tekstFarve);
    text(tekst, x+sizeX/2, y+sizeY/2);
  }
  boolean musOver() {
    if (mouseX>x-camX && mouseX<x+sizeX-camX && mouseY>y-camY && mouseY<y+sizeY-camY) {
      return true;
    } else {
      return false;
    }
  }
  void klik() {
    println("Klik!");
  }
}

MatRegnGenstartKnap matRegnGenstartKnap;

class MatRegnGenstartKnap extends Knap {
  MatRegnGenstartKnap(float X, float Y, float SIZEX, float SIZEY, color FARVE, color HOVERFARVE, color KLIKFARVE, String TEKST, float TEKSTSIZE, color TEKSTFARVE) {
    super(X, Y, SIZEX, SIZEY, FARVE, HOVERFARVE, KLIKFARVE, TEKST, TEKSTSIZE, TEKSTFARVE);
  }
  @Override
    void klik() {
    skiftTilMatRegn();
    tutorial = false;
    matRegnGenstartKnap.isActive = false;
    tilbageKnap.isActive = false;
  }
}

MinusVenusGenstartKnap minusVenusGenstartKnap;

class MinusVenusGenstartKnap extends Knap {
  MinusVenusGenstartKnap(float X, float Y, float SIZEX, float SIZEY, color FARVE, color HOVERFARVE, color KLIKFARVE, String TEKST, float TEKSTSIZE, color TEKSTFARVE) {
    super(X, Y, SIZEX, SIZEY, FARVE, HOVERFARVE, KLIKFARVE, TEKST, TEKSTSIZE, TEKSTFARVE);
  }
  @Override
    void klik() {
    skiftTilMinusVenus();
    tutorial = false;
    minusVenusGenstartKnap.isActive = false;
    tilbageKnap.isActive = false;
  }
}

TilbageKnap tilbageKnap;

class TilbageKnap extends Knap {
  TilbageKnap(float X, float Y, float SIZEX, float SIZEY, color FARVE, color HOVERFARVE, color KLIKFARVE, String TEKST, float TEKSTSIZE, color TEKSTFARVE) {
    super(X, Y, SIZEX, SIZEY, FARVE, HOVERFARVE, KLIKFARVE, TEKST, TEKSTSIZE, TEKSTFARVE);
  }
  @Override
    void klik() {
    skiftTilHjem();
    for(Knap knap : knapper){
      knap.isActive = false;
    }
  }
}

//class knapTemplate extends Knap{
//  knapTemplate(float X, float Y, float SIZEX, float SIZEY, color FARVE, color HOVERFARVE, color KLIKFARVE, String TEKST, float TEKSTSIZE, color TEKSTFARVE){
//    super(X, Y, SIZEX, SIZEY, FARVE, HOVERFARVE, KLIKFARVE, TEKST, TEKSTSIZE, TEKSTFARVE);
//  }
//  @Override
//  void klik(){
//
//  }
//}
