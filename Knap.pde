ArrayList<Knap> knapper = new ArrayList<Knap>();

class Knap {
  float x, y, sizeX, sizeY;
  color farve, hoverFarve, klikFarve;
  String tekst;
  float tekstSize;
  color tekstFarve;
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
    text(tekst, x+sizeX/2-camX, y+sizeY/2-camY);
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

TilbageKnap tilbageKnap;

class TilbageKnap extends Knap {
  TilbageKnap(float X, float Y, float SIZEX, float SIZEY, color FARVE, color HOVERFARVE, color KLIKFARVE, String TEKST, float TEKSTSIZE, color TEKSTFARVE) {
    super(X, Y, SIZEX, SIZEY, FARVE, HOVERFARVE, KLIKFARVE, TEKST, TEKSTSIZE, TEKSTFARVE);
  }
  @Override
    void klik() {
    skiftTilHjem();
    matRegnGenstartKnap.isActive = false;
    tilbageKnap.isActive = false;
  }
}

MatRegnStartKnap matRegnStartKnap;

class MatRegnStartKnap extends Knap {
  MatRegnStartKnap(float X, float Y, float SIZEX, float SIZEY, color FARVE, color HOVERFARVE, color KLIKFARVE, String TEKST, float TEKSTSIZE, color TEKSTFARVE) {
    super(X, Y, SIZEX, SIZEY, FARVE, HOVERFARVE, KLIKFARVE, TEKST, TEKSTSIZE, TEKSTFARVE);
  }
  @Override
    void klik() {
    matRegnStartKnap.isActive=false;
    minusPåVenusStartKnap.isActive=false;
    gangeMedLangeKnap.isActive=false;
    påMissionMedDivisionKnap.isActive=false;
    doodlejumpStartKnap.isActive=false;
    camX=0;
    camY=0;
    sted=matRegn;
  }
  @Override
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
    if (matRegnAchivements.maxScore==0) {
      text(tekst, x+sizeX/2-camX, y+sizeY/2-camY);
    } else {
      text(tekst+" - højeste score: "+matRegnAchivements.maxScore, x+sizeX/2-camX, y+sizeY/2-camY);
      if (matRegnAchivements.maxScore>=matRegnAchivements.bronzeThreshhold) {
        fill(205, 127, 50);
        if (matRegnAchivements.maxScore>=matRegnAchivements.authorThreshhold) {
          fill(0,180,0);
        } else if (matRegnAchivements.maxScore>=matRegnAchivements.guldThreshhold) {
          fill(229,184,11);
        } else if (matRegnAchivements.maxScore>=matRegnAchivements.sølvThreshhold) {
          fill(165,169,180);
        }
        pushMatrix();
        translate(x+height/30-camX, y+(height/10-width/200)/2-camY);
        tegnStjerne();
        popMatrix();
      }
    }
  }
}

MinusPåVenusStartKnap minusPåVenusStartKnap;

class MinusPåVenusStartKnap extends Knap {
  MinusPåVenusStartKnap(float X, float Y, float SIZEX, float SIZEY, color FARVE, color HOVERFARVE, color KLIKFARVE, String TEKST, float TEKSTSIZE, color TEKSTFARVE) {
    super(X, Y, SIZEX, SIZEY, FARVE, HOVERFARVE, KLIKFARVE, TEKST, TEKSTSIZE, TEKSTFARVE);
  }
  @Override
    void klik() {
    matRegnStartKnap.isActive=false;
    minusPåVenusStartKnap.isActive=false;
    gangeMedLangeKnap.isActive=false;
    påMissionMedDivisionKnap.isActive=false;
    doodlejumpStartKnap.isActive=false;
    camX=0;
    camY=0;
  }
  @Override
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
    if (minusPåVenusAchivements.maxScore==0) {
      text(tekst, x+sizeX/2-camX, y+sizeY/2-camY);
    } else {
      text(tekst+" - højeste score: "+minusPåVenusAchivements.maxScore, x+sizeX/2-camX, y+sizeY/2-camY);
      if (minusPåVenusAchivements.maxScore>=minusPåVenusAchivements.bronzeThreshhold) {
        fill(205, 127, 50);
        if (minusPåVenusAchivements.maxScore>=minusPåVenusAchivements.authorThreshhold) {
          fill(0,180,0);
        } else if (minusPåVenusAchivements.maxScore>=minusPåVenusAchivements.guldThreshhold) {
          fill(229,184,11);
        } else if (minusPåVenusAchivements.maxScore>=minusPåVenusAchivements.sølvThreshhold) {
          fill(165,169,180);
        }
        pushMatrix();
        translate(x+height/30-camX, y+(height/10-width/200)/2-camY);
        tegnStjerne();
        popMatrix();
      }
    }
  }
}

GangeMedLangeKnap gangeMedLangeKnap;

class GangeMedLangeKnap extends Knap {
  GangeMedLangeKnap(float X, float Y, float SIZEX, float SIZEY, color FARVE, color HOVERFARVE, color KLIKFARVE, String TEKST, float TEKSTSIZE, color TEKSTFARVE) {
    super(X, Y, SIZEX, SIZEY, FARVE, HOVERFARVE, KLIKFARVE, TEKST, TEKSTSIZE, TEKSTFARVE);
  }
  @Override
    void klik() {
  }
}

PåMissionMedDivisionKnap påMissionMedDivisionKnap;

class PåMissionMedDivisionKnap extends Knap {
  PåMissionMedDivisionKnap(float X, float Y, float SIZEX, float SIZEY, color FARVE, color HOVERFARVE, color KLIKFARVE, String TEKST, float TEKSTSIZE, color TEKSTFARVE) {
    super(X, Y, SIZEX, SIZEY, FARVE, HOVERFARVE, KLIKFARVE, TEKST, TEKSTSIZE, TEKSTFARVE);
  }
  @Override
    void klik() {
  }
}

DoodlejumpStartKnap doodlejumpStartKnap;

class DoodlejumpStartKnap extends Knap {
  DoodlejumpStartKnap(float X, float Y, float SIZEX, float SIZEY, color FARVE, color HOVERFARVE, color KLIKFARVE, String TEKST, float TEKSTSIZE, color TEKSTFARVE) {
    super(X, Y, SIZEX, SIZEY, FARVE, HOVERFARVE, KLIKFARVE, TEKST, TEKSTSIZE, TEKSTFARVE);
  }
  @Override
    void klik() {
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
