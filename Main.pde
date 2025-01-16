Dyr flemming;

float blinkTime = random(1, 60);
float blinkTimer = 0;

float camX = 0;
float camY = 0;

//statemachine med hvilken skærm der skal vises
int sted = 0;

int hjem = 0;
int spil = 1;

//statemachine der holder styr på hvilket rum Flemming er i, i huset
int rum=0;

int leverum=0;
int legerum=1;
int skinrum=2;
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
}
void draw() {
  if (sted == hjem) {
    Hjem();
  }
  //blink timer
  if (millis()-blinkTimer >= blinkTime*1000) {
    flemming.blink(500);
    blinkTimer = millis();
    blinkTime = random(1, 60);
  }
}

void Hjem() {
  stroke(0);
  background(100, 50, 50);
  fill(100);
  stroke(0);
  strokeWeight(3);
  rect(-10-camX, height*0.8-camY, width+width+21, height*0.2);
  flemming.tegnDyr();
  tegnMadDrikke();
  tunge();
  fill(0);
  text(flemming.dybde, 100, 100);
  text(flemming.dimensionalitet, 100, 200);
  //rect(width/2-width/8,height/3*2-height/16,width/4,height/4);
  //bruges til at bestemme hvor langt musen har flyttet sig i den sidste frame til brug i hastigheden til masstykkerne
  prevX=mouseX;
  prevY=mouseY;
  //camX = lerp(camX, width, 0.001);
  //pilen til kælderen
  strokeCap(ROUND);
  strokeWeight(10);

  if (mouseX>width/2-width/20-camX && mouseY>height/30*27-camY && mouseX<width/2+width/20-camX && mouseY<height/15*14-camY) {
    stroke(200);
  } else {
    stroke(150);
  }
  line(width/2-camX, height/15*14-camY, width/2+width/20-camX, height/30*27-camY);
  line(width/2-camX, height/15*14-camY, width/2-width/20-camX, height/30*27-camY);

  if (mouseX>width/20*19-height/30-camX && mouseY>height/2-width/20-camY && mouseX<width/20*19-camX && mouseY<height/2+width/20-camY) {
    stroke(200);
  } else {
    stroke(150);
  }
  line(width/20*19-camX, height/2-camY, width/20*19-height/30-camX, height/2+width/20-camY);
  line(width/20*19-camX, height/2-camY, width/20*19-height/30-camX, height/2-width/20-camY);

  strokeWeight(3);
  if (rum==legerum) {
    flemming.y=lerp(flemming.y, height*1.6, 0.1);
    camY=lerp(camY, height, 0.05);
  }
  if(rum==skinrum){
    flemming.x=lerp(flemming.x, width*1.4, 0.1);
    camX=lerp(camX, width, 0.05);
  }
}


void mousePressed() {
  //når man trykker på flemming så blinker han
  if (mouseX > flemming.x+flemming.sizeY*tan(flemming.angle)*0.5
    && mouseX < flemming.x+flemming.sizeX+flemming.sizeY*tan(flemming.angle)-flemming.sizeY*tan(flemming.angle)*0.5
    && mouseY > flemming.y && mouseY < flemming.y+flemming.sizeY) {

    flemming.blink(500);
  }
  if (sted == hjem) {
    if (MadIHånden) {
      MadIHånden = false; // No longer in hand
      MadPartikler.get(MadPartikler.size()-1).GivSlip(); // Release the food particle
    } else {
      double ellipseDecider = ((Math.pow(mouseX - (width / 13 * 11-camX), 2) / Math.pow(width / 14, 2)) +
        (Math.pow(mouseY - (height / 20 * 16-camY), 2) / Math.pow(height / 13, 2)));
      if (ellipseDecider <= 1) {
        MadPartikler.add(new MadPartikel());
        MadIHånden = true; // Pick up the particle
      }
    }
    if (mouseX>width/2-width/20-camX && mouseY>height/30*27-camY && mouseX<width/2+width/20-camX && mouseY<height/15*14-camY) {
      rum=legerum;
    }
    if (mouseX>width/20*19-height/30-camX && mouseY>height/2-width/20-camY && mouseX<width/20*19-camX && mouseY<height/2+width/20-camY) {
      rum=skinrum;
    }
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
  if (key == 'd' && flemming.harDrukket == false && sted == hjem) {
    flemming.flytterTilVand = true;
    flemming.dimensionalitet += 1;
  }
  if (key == 'p') {
    flemming.sizeY *= 0.5;
    flemming.sizeX *= 0.5;
  }
}
