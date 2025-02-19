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
float boulderSize;

float tilt = 0;
float flemmingX = -1;

class Hul {
  float x;
  float y;
  boolean fyldt = false;
  HulSamling parent;
  HulSamlingSamling grandParent;
  Hul(float x, float y, HulSamling parent, HulSamlingSamling grandParent) {
    this.x = x;
    this.y = y;
    this.parent = parent;
    this.grandParent = grandParent;
  }
  void tegn(){
    fill(0);
    stroke(0);
    ellipse(x+parent.x, y+grandParent.y, boulderSize, boulderSize*0.4);
  }
}

class HulSamling{
  float x;
  float y;
  float sizeX;
  float sizeY;
  int antalHuller;
  ArrayList<Hul> huller = new ArrayList<Hul>();
  HulSamlingSamling parent;
  HulSamling(float x, float sizeX, float sizeY, int antalHuller, HulSamlingSamling parent){
    this.x = x;
    this.parent = parent;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    this.antalHuller = antalHuller;
    for(int i=0;i<antalHuller;i++){
      huller.add(new Hul(random(boulderSize/2, sizeX-boulderSize/2), random(boulderSize*0.4/2, sizeY-boulderSize*0.4/2), this, parent));
    }
  }
  void tegn(){
    for(Hul hul : huller){
      hul.tegn();
    }
  }
}

class HulSamlingSamling{
  float x;
  float y;
  float sizeX;
  float sizeY;
  HulSamling samling1;
  HulSamling samling2;
  HulSamlingSamling(float x, float y, float sizeX, float sizeY, int antalHuller1, int antalHuller2){
    this.x = x;
    this.y = y;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    samling1 = new HulSamling(x, sizeX/2, sizeY, antalHuller1, this);
    samling2 = new HulSamling(x+sizeX/2, sizeX/2, sizeY, antalHuller2, this);
  }
  void tegn(){
    samling1.tegn();
    samling2.tegn();
    stroke(180*0.8, 120*0.8, 50*0.8);
    strokeWeight(10);
    line(x+sizeX/2, y, x+sizeX/2, y+sizeY);
    strokeWeight(3);
    stroke(0);
    tegnSkilt(x+sizeX*0.1, y, width*0.1, width*0.05, color(125, 80, 10), str(samling1.antalHuller), width*0.05, color(255));
    tegnSkilt(x+sizeX*0.9, y, width*0.1, width*0.05, color(125, 80, 10), str(samling2.antalHuller), width*0.05, color(255));
  }
}

HulSamlingSamling hulSamlingen;

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

void tegnSkilt(float x, float y, float sizeX, float sizeY, color signColor, String text, float textSize, color textColor){
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
    if(tilt > 0.999 && tilt != 1){
      tilt = 1;
      hulSamlingen = new HulSamlingSamling(0, -height, width, height/4, round(random(0, 10)), round(random(0, 10)));
    }
    if(tilt == 1){
      hulSamlingen.y = lerp(hulSamlingen.y, height/2, 0.1);
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
    if(hulSamlingen != null){
      hulSamlingen.tegn();
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
