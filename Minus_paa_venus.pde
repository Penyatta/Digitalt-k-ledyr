String[] minusVenusSider = {
  "Velkommen til Minus på Venus\nEt spil der handler om minus.",
  "Du starter med et bestemt antal sten,\nsom du skal rulle over\nden rigtige mængde huller,\nfor at ende ud med det antal der kræves.",
  "Meget simpelt\nDu har 3 liv\nHeld og lykke."
};

int antalBoulders;
float boulderSize;

float tilt = 0;
float flemmingX = -1;
int level = 0;

int tal;
float skiltHøjde = -10*height;

boolean ruller = false;
float rulTime = 0.1;
float rulleTimer = 0;
float rulleHast = 1000;
boolean færdig;
float færdigTime = 1;
float færdigTimer = 0;
HulSamling valgteHulSamling;
ArrayList<Integer> numre;

ArrayList<VenusDecal> venusDecals = new ArrayList<VenusDecal>();
class VenusDecal {
  float x;
  float y;
  float Size = random(width*0.03, width*0.1);
  boolean remove = false;
  VenusDecal(float x, float y) {
    this.x = x;
    this.y = y;
    venusDecals.add(this);
  }
  void tegn() {
    noStroke();
    fill(180*0.9, 120*0.9, 50*0.9);
    ellipse(x-camX, height-y*(1-(tilt*0.3)), Size, Size*(1-(tilt*0.4)));
    if (x-camX+Size < 0) {
      remove = true;
    }
  }
}

class Hul {
  float x;
  float y;
  boolean fyldt = false;
  HulSamling parent;
  HulSamlingSamling grandParent;
  Boulder sten;
  Hul(float x, float y, HulSamling parent, HulSamlingSamling grandParent) {
    this.x = x;
    this.y = y;
    this.parent = parent;
    this.grandParent = grandParent;
  }
  void tegn() {
    fill(0);
    stroke(0);
    ellipse(x+parent.x-camX, y+grandParent.y, boulderSize, boulderSize*0.4);
  }
}

class HulSamling {
  float x;
  float sizeX;
  float sizeY;
  int antalHuller;
  ArrayList<Hul> huller = new ArrayList<Hul>();
  HulSamlingSamling parent;
  HulSamling(float x, float sizeX, float sizeY, int antalHuller, HulSamlingSamling parent) {
    this.x = x;
    this.parent = parent;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    this.antalHuller = antalHuller;
    for (int i=0; i<antalHuller; i++) {
      huller.add(new Hul(random(boulderSize/2, sizeX-boulderSize/2), random(boulderSize*0.4/2, sizeY-boulderSize*0.4/2), this, parent));
    }
  }
  void tegn() {
    for (Hul hul : huller) {
      hul.tegn();
    }
  }
  boolean musOver() {
    if (mouseX > x-camX && mouseX < sizeX+x-camX && mouseY > parent.y && mouseY < parent.y+sizeY) {
      return true;
    } else {
      return false;
    }
  }
}

class HulSamlingSamling {
  float x;
  float y;
  float sizeX;
  float sizeY;
  HulSamling samling1;
  HulSamling samling2;
  HulSamlingSamling(float x, float y, float sizeX, float sizeY, int antalHuller1, int antalHuller2, boolean top) {
    this.x = x;
    this.y = y;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    samling1 = new HulSamling(x, sizeX/2, sizeY, antalHuller1, this);
    samling2 = new HulSamling(x+sizeX/2, sizeX/2, sizeY, antalHuller2, this);
  }
  void tegn() {
    samling1.x = x;
    samling2.x = x+sizeX/2;
    samling1.tegn();
    samling2.tegn();
    stroke(180*0.8, 120*0.8, 50*0.8);
    strokeWeight(10);
    line(x+sizeX/2-camX, y, x+sizeX/2-camX, y+sizeY);
    strokeWeight(3);
    stroke(0);
    if (x+sizeX-camX < 0) {
      forrigeHulSamling = null;
    }
  }
  void tegnSkilte() {
    tegnSkilt(x+sizeX*0.1-camX, y, width*0.1, width*0.05, color(125, 80, 10), "Huller\n"+str(samling1.antalHuller), width*0.02, color(255));
    tegnSkilt(x+sizeX*0.9-camX, y, width*0.1, width*0.05, color(125, 80, 10), "Huller\n"+str(samling2.antalHuller), width*0.02, color(255));
  }
}

HulSamlingSamling hulSamlingen;
HulSamlingSamling forrigeHulSamling;

float boulderOffset;
ArrayList<Boulder> boulders = new ArrayList<Boulder>();
class Boulder {
  float x;
  float y;
  color farve;
  float newX = -width;
  float newY = random(height/3, height*0.4);
  boolean rolling = false;
  boolean doneRolling = false;
  Hul hul;
  Boulder(float x, float y, color farve) {
    this.x = x;
    this.y = y;
    this.farve = farve;
    boulders.add(this);
  }
  void rul() {
    if (x+boulderSize/2-camX < 0) {
      boulders.remove(this);
    }
    if (rolling && valgteHulSamling != null) {
      if (newX == -width) {
        if (hul != null) {
          newX = hul.x+valgteHulSamling.x;
        } else {
          newX = random(valgteHulSamling.x+boulderSize/2, valgteHulSamling.x+valgteHulSamling.sizeX-boulderSize/2);
        }
      }
      if (x != newX) {
        if (x<newX) {
          x+=rulleHast*delta;
          if (x>newX) {
            x=newX;
          }
        }
        if (x>newX) {
          x-=rulleHast*delta;
          if (x<newX) {
            x=newX;
          }
        }
      } else if (y != newY) {
        y-=rulleHast*delta;
        if (hul != null) {
          if (y<hul.y+valgteHulSamling.parent.y) {
            boulders.remove(this);
            antalBoulders-=1;
          }
        }
        if (y<newY) {
          y=newY;
        }
      } else {
        rolling = false;
        doneRolling = true;
      }
    }
  }
  void tegn() {
    fill(farve);
    circle(x-camX-boulderOffset, y, boulderSize);
  }
}

ArrayList<Float> skilte;
void tegnSkilt(float x, float y, float sizeX, float sizeY, color signColor, String text, float textSize, color textColor) {
  fill(signColor);
  stroke(0);
  rect(x, y-sizeX/2, sizeY/4, sizeX/2);
  rect(x-sizeX/2+sizeY/8, y-sizeX/2-sizeY, sizeX, sizeY);
  textAlign(CENTER, CENTER);
  textSize(textSize);
  fill(textColor);
  text(text, x+sizeY/8, y-sizeX/2-sizeY/2);
}

void MinusVenus() {
  if (tutorial) {
    background(0);
    flemming.x = width*0.4;
    flemming.y = height*0.6;
    flemming.sizeX = width/4;
    flemming.sizeY = height/4;
    textBox(minusVenusSider);
  } else if (liv <= 0) {
    camX = 0;
    background(0);
    minusVenusGenstartKnap.isActive = true;
    tilbageKnap.isActive = true;
    flemming.x = width*0.42;
    flemming.y = height*0.37;
    flemming.sizeX = width/4;
    flemming.sizeY = height/4;
    textAlign(CENTER, CENTER);
    textSize(width*0.1);
    fill(255);
    if (point>=minusPåVenusAchivements.maxScore) {
      text("Godt gået", width*0.5, height*0.1);
      minusPåVenusAchivements.maxScore=point;
      highscores.setInt("Minus På Venus highscore", point);
      flemming.humør = "glad";
    } else {
      text("Kom igen", width*0.5, height*0.1);
      flemming.humør = "trist";
    }
    textSize(width*0.05);
    text("Point: "+str(point)+" Højeste point: "+minusPåVenusAchivements.maxScore, width*0.5, height*0.3);
  } else {
    tilt = constrain(lerp(tilt, 1, 2*delta), 0, 1);
    if (tilt > 0.999 && tilt != 1) {
      tilt = 1;
      hulSamlingen = new HulSamlingSamling(0, -height, width, height/4, round(random(0, antalBoulders-1)), round(random(0, antalBoulders-1)), true);
      if (random(10000) > 5000) {
        tal = antalBoulders-hulSamlingen.samling1.antalHuller;
      } else {
        tal = antalBoulders-hulSamlingen.samling1.antalHuller;
      }
      skilte.add(float(width/2));
      numre.add(tal);
    }
    if (tilt == 1) {
      hulSamlingen.y = min(lerp(hulSamlingen.y, height/2, 4*delta), height/2);
      flemmingX = min(lerp(flemmingX, 1, 3*delta), 1);
      skiltHøjde = min(lerp(skiltHøjde, height*0.31, 4*delta), height*0.31);
      camX = min(lerp(camX, level*width, 2*delta), level*width);
      flemming.x = min(lerp(flemming.x, width*0.8*flemmingX+width*level, 3*delta), width*0.8*flemmingX+width*level);
      boulderOffset = max(lerp(boulderOffset, 0, 2*delta), 0);
    }
    flemming.y = height*0.8;
    flemming.sizeX = width/4*0.7;
    flemming.sizeY = height/4*0.7;
    background(180, 120, 50);
    for (int i=0; i<venusDecals.size(); i++) {
      if (venusDecals.get(i).remove) {
        venusDecals.remove(venusDecals.get(i));
      }
    }
    for (VenusDecal decal : venusDecals) {
      decal.tegn();
    }
    fill(0);
    rect(0, 0, width, height*0.3*tilt);
    for (int i=0; i<height*0.3*tilt; i++) {
      float p = float(i)/(height*0.3*tilt);
      //200 180 50
      //150 100 30
      stroke(150+(200-150)*p, 100+(180-100)*p, 30+(50-30)*p);
      line(0, i, width, i);
    }
    for (int i=0; i<skilte.size(); i++) {
      if (skilte.get(i)-width*0.05/8-camX+width*0.1 < 0) {
        skilte.remove(skilte.get(i));
        numre.remove(numre.get(i));
      }
      tegnSkilt(skilte.get(i)-width*0.05/8-camX, skiltHøjde, width*0.1, width*0.05, color(125, 80, 10), "Kræver\n"+str(numre.get(i))+" sten.", width*0.02, color(255));
    }
    if (hulSamlingen != null) {
      hulSamlingen.tegn();
    }
    if (forrigeHulSamling != null) {
      forrigeHulSamling.tegn();
    }
    stroke(0);
    if (ruller) {
      rulleTimer+=delta;
      if (rulleTimer >= rulTime) {
        for (int i=0; i<boulders.size(); i++) {
          if (boulders.get(i).doneRolling == false && boulders.get(i).rolling == false) {
            boulders.get(i).rolling = true;
            rulleTimer = 0;
            break;
          }
        }
      }
    }
    for (int i=0; i<boulders.size(); i++) {
      boulders.get(i).rul();
    }
    for (int i=0; i<boulders.size(); i++) {
      boulders.get(i).tegn();
    }
    if (hulSamlingen != null) {
      hulSamlingen.tegnSkilte();
    }
    if (forrigeHulSamling != null) {
      forrigeHulSamling.tegnSkilte();
    }
    textAlign(RIGHT, TOP);
    textSize(width*0.05);
    fill(255);
    text(str(antalBoulders)+" sten.", width*0.95, height*0.05);
    textAlign(LEFT, CENTER);
    text("Point: "+point, width*0.05, height*0.1);
    text("Liv: "+liv, width*0.05, height*0.2);
    for (int i=0; i<boulders.size(); i++) {
      if (boulders.get(i).doneRolling == true) {
        færdig = true;
      } else {
        færdig = false;
        break;
      }
    }
  }
  flemming.tegnDyr();
  if (færdig) {
    færdigTimer+=delta;
    textAlign(CENTER, CENTER);
    textSize(width*0.2);
    if (antalBoulders == tal) {
      fill(0, 255, 0, 50);
      rect(0, 0, width, height);
      fill(255);
      text("Korrekt!", width/2, height/2);
    } else {
      fill(255, 0, 0, 50);
      rect(0, 0, width, height);
      fill(255);
      text("Forkert!", width/2, height/2);
    }
    if (færdigTimer >= færdigTime) {
      forrigeHulSamling = hulSamlingen;
      valgteHulSamling = null;
      if (antalBoulders == tal) {
        maxTal += 1;
        point += 1;
      } else if(antalBoulders != tal) {
        liv-=1;
      }
      level += 1;
      antalBoulders = round(random(2, maxTal));
      for (int i=0; i<antalBoulders; i++) {
        new Boulder(random(width*0.3+width*level, width*0.7+width*level), random(height*0.8, height*0.95), color(random(100, 150), random(80, 120), random(10, 30)));
      }
      hulSamlingen = new HulSamlingSamling(0+width*level, height/2, width, height/4, round(random(0, antalBoulders-1)), round(random(0, antalBoulders-1)), true);
      if (random(10000) > 5000) {
        tal = antalBoulders-hulSamlingen.samling1.antalHuller;
      } else {
        tal = antalBoulders-hulSamlingen.samling2.antalHuller;
      }
      venusDecals = new ArrayList<VenusDecal>();
      for (int i=0; i<30; i++) {
        VenusDecal decal = new VenusDecal(random(width*level, width*level+width), random(height*0.3, height));
      }
      skilte.add(float(width/2)+width*level);
      numre.add(tal);
      ruller = false;
      færdigTimer = 0;
      færdig = false;
    }
  }
}

void skiftTilMinusVenus() {
  sted = minusVenus;
  tutorial = true;
  tilt = 0;
  liv = 3;
  point = 0;
  skiltHøjde = -10*height;
  side = 0;
  level = 0;
  maxTal = 2;
  færdig = false;
  ruller = false;
  færdigTimer = 0;
  flemmingX = -1;
  boulderOffset = width;
  flemming.humør = "glad";
  boulders = new ArrayList<Boulder>();
  antalBoulders = round(random(2, maxTal));
  numre = new ArrayList<Integer>();
  skilte = new ArrayList<Float>();
  for (int i=0; i<antalBoulders; i++) {
    new Boulder(random(width*0.3, width*0.7), random(height*0.8, height*0.95), color(random(100, 150), random(80, 120), random(10, 30)));
  }
  venusDecals = new ArrayList<VenusDecal>();
  for (int i=0; i<30; i++) {
    VenusDecal decal = new VenusDecal(random(width), random(height*0.3, height));
  }
  disableSkins();
}
