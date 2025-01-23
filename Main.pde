Dyr flemming;

float blinkTime = random(1, 60);
float blinkTimer = 0;

float camX = 0;
float camY = 0;

int sted = 0;

int hjem = 0;
int spil = 1;

float delta;
float deltaTime = millis();

boolean isNan(float val) {
  return val != val;
}

ArrayList<PVector> bølgePunkter = new ArrayList<PVector>();

void setup() {
  fullScreen();
  Madskål=loadImage("Madskål.png");
  WaterBottle=loadImage("HamsterWater5.0.png");
  strokeWeight(3);
  flemming = new Dyr();
  for (int i=0; i<height/250*2; i++) {
    for (float x=width/40; x<width*0.105; x+=4) {
      bølgePunkter.add(new PVector(x, i+sin(x/10)*height/250));
    }
  }
  vandBølge = -height*0.004;
  partikler = new ArrayList<>();
}
void draw() {
  delta = (millis()-deltaTime)/1000;
  deltaTime = millis();
  if (sted == hjem) {
    Hjem();
  }
  //blink timer
  if (millis()-blinkTimer >= blinkTime*1000) {
    flemming.blink(500);
    blinkTimer = millis();
    blinkTime = random(1, 60);
  }
  for (int i = 0; i < partikler.size(); i++) {
    Partikel p = partikler.get(i);
    p.bevæg();
    p.tegn();
    if (p.erDød()) {
      partikler.remove(i);
    }
  }
}

void Hjem() {
  stroke(0);
  background(100, 50, 50);
  fill(100);
  stroke(0);
  strokeWeight(3);
  rect(-10-camX, height*0.8-camY, width+21, height*0.2);
  flemming.tegnDyr();
  tegnMadDrikke();
  tunge();
  fill(0);
  text(flemming.dybde, 100, 100);
  text(flemming.dimensionalitet, 100, 200);
  //rect(width/2-width/8,height/3*2-height/16,width/4,height/4);
  prevX=mouseX;
  prevY=mouseY;
  //camX = lerp(camX, width, 0.001);
}


void mousePressed() {
  //når man trykker på flemming så blinker han
  if (mouseX > flemming.x+flemming.sizeY*tan(flemming.angle)*0.5
    && mouseX < flemming.x+flemming.sizeX+flemming.sizeY*tan(flemming.angle)-flemming.sizeY*tan(flemming.angle)*0.5
    && mouseY > flemming.y && mouseY < flemming.y+flemming.sizeY) {

    flemming.blink(500);
    for (int i = 0; i < 3; i++) {
      partikler.add(new Hjerte(mouseX, mouseY));
    }
  }
  if (sted == hjem) {
    if (mouseX > width/50-camX && mouseX < width/50+width/11-camX && mouseY > height/7*2-camY && mouseY < height/7*2+height/3+height/25-camY && flemming.harDrukket == false && sted == hjem) {
      flemming.flytterTilVand = true;
      flemming.dimensionalitet += 1;
    }
    if (MadIHånden) {
      MadIHånden = false; // No longer in hand
      MadPartikler.get(MadPartikler.size()-1).GivSlip(); // Release the food particle
    } else {
      double ellipseDecider = ((Math.pow(mouseX - (width / 13 * 11-camX), 2) / Math.pow(width / 14, 2)) +
        (Math.pow(mouseY - (height / 20 * 16-camY), 2) / Math.pow(height / 13, 2)));
      if (ellipseDecider <= 1) {
        for (int i=0; i<10; i++) {
          partikler.add(new Gnister(mouseX, mouseY, color(154, 102, 63)));
        }
        MadPartikler.add(new MadPartikel());
        MadIHånden = true; // Pick up the particle
      }
    }
  }
  if (sted==0) {
    //gør noget
  }
}
//når man trykker på forskellige knapper så skifter flemming humør (dette er for nemt at tjekke hvordan han ser ud i forskellige humør)
void keyPressed() {
  if (key == 's') {
    flemming.humør = "sur";
  }
  if (key == 'g') {
    flemming.humør = "glad";
  }
  if (key == 't') {
    flemming.humør = "trist";
  }
  if (key == 'p') {
    flemming.sizeY *= 0.5;
    flemming.sizeX *= 0.5;
  }
}
