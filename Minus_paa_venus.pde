String[] minusVenusSider = {
  "Velkommen til Minus på Venus\nJeg vil ikke fortælle dig hvordan det virker.\nDet er Sørens opgave"
};

ArrayList<VenusDecal> venusDecals = new ArrayList<VenusDecal>();
class VenusDecal {
  float x = random(width);
  float y = random(height);
  float Size = random(width*0.03, width*0.1);
  VenusDecal() {
    venusDecals.add(this);
  }
  void tegn() {
    noStroke();
    fill(180*0.9, 120*0.9, 50*0.9);
    ellipse(x, height-y*(1-(tilt*0.3)), Size, Size*(1-(tilt*0.4)));
  }
}

int antalBoulders;
int boulderSize;
float tilt = 0;
float flemmingX = -1;

class Hul {
  float x;
  float y;
  boolean fyldt = false;
  Hul(float x, float y) {
    this.x = x;
    this.y = y;
  }
  void tegn(){
    fill(0);
    ellipse(x, y, boulderSize, boulderSize*0.4);
  }
}

class HulSamling{
  float x;
  float y;
  int antalHuller;
  ArrayList<Hul> huller = new ArrayList<Hul>();
}

ArrayList<Boulder> boulders = new ArrayList<Boulder>();
class Boulder {
  float x;
  float y;
  color farve;
  Boulder(float x, float y, color farve) {
    this.x = x;
    this.y = y;
    this.farve = farve;
  }
  void tegn(){
    circle(x, y, boulderSize);
  }
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
    background(0);
    minusVenusGenstartKnap.isActive = true;
    tilbageKnap.isActive = true;
    textAlign(CENTER, CENTER);
    textSize(width*0.1);
    fill(255);
    text("DU TABTE", width*0.5, height*0.1);
    textSize(width*0.05);
    text("Point: "+str(point), width*0.5, height*0.3);
    flemming.x = width*0.42;
    flemming.y = height*0.37;
    flemming.sizeX = width/4;
    flemming.sizeY = height/4;
    flemming.humør = "trist";
  } else {
    tilt = constrain(lerp(tilt, 1, 2*delta), 0, 1);
    if(tilt > 0.999){
      tilt = 1;
    }
    if(tilt == 1){
      flemmingX = constrain(lerp(flemmingX, 1, 2*delta), -1, 1);
      flemming.x = width*0.8*flemmingX;
    }
    flemming.y = height*0.8;
    flemming.sizeX = width/4*0.7;
    flemming.sizeY = height/4*0.7;
    background(180, 120, 50);
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
    stroke(0);
  }
  flemming.tegnDyr();
}

void skiftTilMinusVenus() {
  sted = minusVenus;
  tutorial = true;
  liv = 3;
  point = 0;
  side = 0;
  flemming.humør = "glad";
  boulders = new ArrayList<Boulder>();
  venusDecals = new ArrayList<VenusDecal>();
  for (int i=0; i<20; i++) {
    VenusDecal decal = new VenusDecal();
  }
}
