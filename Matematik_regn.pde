String[] matRegnSider = {
  "Velkommen til Matematik regn,\net spil der handler om at regne hurtigt."
  , "Spillet starter med at vise dig et regnestykke.\nDet du skal gøre er at finde en af de faldene tal,\n og klikke på det der er svaret til regnestykket\nDu kan kun gætte forkert 3 gange\nfor så er spillet ovre"
  , "\n\nHeld og lykke"
};

int maxTal = 2;
int tal1 = round(random(1, maxTal));
int tal2 = round(random(1, maxTal));
String operator = "+";

float talTime = 4;
float talTimer = millis();
float talHast;

ArrayList<RegnTal> regnTal = new ArrayList<RegnTal>();

class RegnTal {
  int værdi;
  float size;
  float x;
  float y;
  float v = talHast;
  color farve = color(100);
  boolean erLøsning = false;
  RegnTal() {
    if (random(0, 1) > 0.1) {
      værdi = round(random(2, maxTal*2));
    } else {
      værdi = tal1+tal2;
    }
    size = width*0.1;
    x = random(0, width-size);
    y = -size;
    regnTal.add(this);
    if (værdi == tal1+tal2) {
      erLøsning = true;
    }
  }
  void fald() {
    y+=v*delta;
    fill(farve);
    rect(x, y, width*0.1, width*0.1, width*0.01);
    textAlign(CENTER, CENTER);
    fill(255);
    textSize(100);
    text(værdi, x+size/2, y+size/2);
  }
  boolean klik() {
    if (mouseX > x && mouseX < x+size && mouseY > y && mouseY < y+size) {
      return true;
    } else {
      return false;
    }
  }
}

void MatematikRegn() {
  background(0);
  if (tutorial) {
    flemming.x = width*0.4;
    flemming.y = height*0.6;
    flemming.sizeX = width/4;
    flemming.sizeY = height/4;
    textBox(matRegnSider);
  } else if (liv <= 0) {
    regnTal = new ArrayList<RegnTal>();
    matRegnGenstartKnap.isActive = true;
    tilbageKnap.isActive = true;
    flemming.x = width*0.42;
    flemming.y = height*0.37;
    flemming.sizeX = width/4;
    flemming.sizeY = height/4;
    textAlign(CENTER, CENTER);
    textSize(width*0.1);
    fill(255);
    if(point>matRegnAchivements.maxScore){
    text("Godt gået", width*0.5, height*0.1);
    matRegnAchivements.maxScore=point;
    flemming.humør = "glad";
    }
    else{
      text("Kom igen", width*0.5, height*0.1);
      flemming.humør = "trist";
    }
    textSize(width*0.05);
    text("Point: "+str(point)+" Højeste point: "+matRegnAchivements.maxScore, width*0.5, height*0.3);
  } else {
    flemming.x = width*0.8;
    flemming.y = height*0.8;
    flemming.sizeX = width/4*0.7;
    flemming.sizeY = height/4*0.7;
    for (int i=0; i<regnTal.size(); i++) {
      regnTal.get(i).fald();
    }
    for (int i=0; i<regnTal.size(); i++) {
      if (regnTal.get(i).y >= height*0.78) {
        if (regnTal.get(i).erLøsning) {
          liv -= 1;
          background(255, 0, 0);
        }
        regnTal.remove(regnTal.get(i));
      }
    }
    fill(100);
    rect(0, height*0.78, width, height*0.22);
    textAlign(LEFT, CENTER);
    fill(255);
    textSize(width*0.05);
    text(tal1+" "+operator+" "+tal2+" = ???", width*0.1, height*0.89);
    textAlign(RIGHT, CENTER);
    text("Point: "+point, width*0.95, height*0.1);
    text("Liv: "+liv, width*0.95, height*0.2);
    if (millis() > talTimer+talTime*1000) {
      talTimer = millis();
      RegnTal r = new RegnTal();
    }
  }
  flemming.tegnDyr();
}

void skiftTilMatRegn() {
  camX=0;
  camY=0;
  sted = matRegn;
  tutorial = true;
  liv = 3;
  point = 0;
  side = 0;
  talHast = height*0.05;
  maxTal = 2;
  talTimer = millis();
  regnTal = new ArrayList<RegnTal>();
  tal1 = round(random(1, maxTal));
  tal2 = round(random(1, maxTal));
  flemming.humør = "glad";
}
