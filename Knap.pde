ArrayList<Knap> knapper = new ArrayList<Knap>();

//Den overordnede knap class
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
  //tegner knappen og ændrer hvordan den ser ud alt efter om musen er over den eller om den er blevet trykket
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
  //tjekker om musen er over knappen
  boolean musOver() {
    if (mouseX>x-camX && mouseX<x+sizeX-camX && mouseY>y-camY && mouseY<y+sizeY-camY) {
      return true;
    } else {
      return false;
    }
  }
  //tom click funktion
  void klik() {
    println("Klik!");
  }
}

//Knappen til at kunne genstarte matematik
MatRegnGenstartKnap matRegnGenstartKnap;

class MatRegnGenstartKnap extends Knap {
  MatRegnGenstartKnap(float X, float Y, float SIZEX, float SIZEY, color FARVE, color HOVERFARVE, color KLIKFARVE, String TEKST, float TEKSTSIZE, color TEKSTFARVE) {
    super(X, Y, SIZEX, SIZEY, FARVE, HOVERFARVE, KLIKFARVE, TEKST, TEKSTSIZE, TEKSTFARVE);
  }
  @Override
    void klik() {
    // sætter mat regn igang uden at aktivere tutorial og fjerner knapperne
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
    // går tilbage til hjem og fjerner knapperne
    skiftTilHjem();
    for(Knap knap : knapper){
      knap.isActive = false;
    }
  }
}

MatRegnStartKnap matRegnStartKnap;

class MatRegnStartKnap extends Knap {
  MatRegnStartKnap(float X, float Y, float SIZEX, float SIZEY, color FARVE, color HOVERFARVE, color KLIKFARVE, String TEKST, float TEKSTSIZE, color TEKSTFARVE) {
    super(X, Y, SIZEX, SIZEY, FARVE, HOVERFARVE, KLIKFARVE, TEKST, TEKSTSIZE, TEKSTFARVE);
  }
  @Override
    void klik() {
    //sætter spille knapperne til inaktive og skifter til mat regn
    slukTændSpilKnapper(false);
    for (int i=0; i<SkinKnapper.size(); i++) {
      Knap knap = SkinKnapper.get(i);
      knap.isActive=true;
    }
    skiftTilMatRegn();
  }
  @Override
    void tegnKnap() {
    //tegner knappen som i den overordnede men ikke teksten fordi der tilføjes max point hvis man har spillet det og stjerner tilføjes også
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
          fill(0, 180, 0);
        } else if (matRegnAchivements.maxScore>=matRegnAchivements.guldThreshhold) {
          fill(229, 184, 11);
        } else if (matRegnAchivements.maxScore>=matRegnAchivements.sølvThreshhold) {
          fill(165, 169, 180);
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
    //sætter knapperne til inaktiv og skifter til minus på venus
    slukTændSpilKnapper(false);
    skiftTilMinusVenus();
    for (int i=0; i<SkinKnapper.size(); i++) {
      Knap knap = SkinKnapper.get(i);
      knap.isActive=true;
    }
    camX=0;
    camY=0;
  }
  @Override
    void tegnKnap() {
    //tegner knappen som i den overordnede men ikke teksten fordi der tilføjes max point hvis man har spillet det og stjerner tilføjes også
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
          fill(0, 180, 0);
        } else if (minusPåVenusAchivements.maxScore>=minusPåVenusAchivements.guldThreshhold) {
          fill(229, 184, 11);
        } else if (minusPåVenusAchivements.maxScore>=minusPåVenusAchivements.sølvThreshhold) {
          fill(165, 169, 180);
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

//knap til spil der ikke kommer til at eksistere
class GangeMedLangeKnap extends Knap {
  GangeMedLangeKnap(float X, float Y, float SIZEX, float SIZEY, color FARVE, color HOVERFARVE, color KLIKFARVE, String TEKST, float TEKSTSIZE, color TEKSTFARVE) {
    super(X, Y, SIZEX, SIZEY, FARVE, HOVERFARVE, KLIKFARVE, TEKST, TEKSTSIZE, TEKSTFARVE);
  }
  @Override
    void klik() {
  }
}

PåMissionMedDivisionKnap påMissionMedDivisionKnap;

//knap til spil der ikke kommer til at eksistere
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

void slukTændSpilKnapper(boolean SlukEllerTænd) {
  matRegnStartKnap.isActive=SlukEllerTænd;
  minusPåVenusStartKnap.isActive=SlukEllerTænd;
  gangeMedLangeKnap.isActive=SlukEllerTænd;
  påMissionMedDivisionKnap.isActive=SlukEllerTænd;
  doodlejumpStartKnap.isActive=SlukEllerTænd;
}

VælgSkinKnap blåSkinKnap;
VælgSkinKnap rødSkinKnap;
VælgSkinKnap grønSkinKnap;
VælgSkinKnap pinkSkinKnap;
VælgSkinKnap limeSkinKnap;
VælgSkinKnap bronzeSkinKnap;
VælgSkinKnap sølvSkinKnap;
VælgSkinKnap guldSkinKnap;

ArrayList<Knap> SkinKnapper = new ArrayList<Knap>();

class VælgSkinKnap extends Knap {
  int nummer;
  int threshHold;
  boolean Reached=false;
  VælgSkinKnap(float X, float Y, float SIZEX, float SIZEY, color FARVE, color HOVERFARVE, color KLIKFARVE, String TEKST, float TEKSTSIZE, color TEKSTFARVE, int NUMMER, int THRESHHOLD) {
    super(X, Y, SIZEX, SIZEY, FARVE, HOVERFARVE, KLIKFARVE, TEKST, TEKSTSIZE, TEKSTFARVE);
    nummer=NUMMER;
    threshHold=THRESHHOLD;
    y=y+nummer*sizeY;
    SkinKnapper.add(this);
  }
  @Override
    void klik() {
    if (Reached) {
      skin=nummer;
    }
  }
  @Override
    void tegnKnap() {
    fill(0);
    rect(x-camX, y-camY, sizeX, sizeY);
    if (musOver()) {
      if (mousePressed) {
        fill(skinFarver[nummer], 150);
      } else {
        fill(skinFarver[nummer], 220);
      }
    } else {
      fill(skinFarver[nummer]);
    }
    rect(x-camX, y-camY, sizeX, sizeY);
    textAlign(CENTER, CENTER);
    textSize(tekstSize);
    fill(tekstFarve);
    text(tekst, x+sizeX/2-camX, y+sizeY/2-camY);
    if (!Reached) {
      fill(0, 100);
      rect(x-camX, y-camY, sizeX, sizeY);
      image(hængelås, x+width/500-camX, y+width/500-camY, sizeY-width/500, sizeY-width/500);
    }
  }
  void TjekThreshhold(int værdi) {
    if (værdi>=threshHold) {
      Reached=true;
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
