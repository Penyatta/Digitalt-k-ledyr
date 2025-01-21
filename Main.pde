Dyr flemming;

float blinkTime = random(1, 60);
float blinkTimer = 0;

float camX = 0;
float camY = 0;

int sted = 1;

int hjem = 0;
int matRegn = 1;

boolean isNan(float val) {
  return val != val;
}

float delta = 0;
float deltaTime = 0;

ArrayList<PVector> bølgePunkter = new ArrayList<PVector>();

boolean tutorial = true;
int side = 0;

void setup() {
  fullScreen();
  frameRate(100);
  Madskål=loadImage("Madskål.png");
  WaterBottle=loadImage("HamsterWater5.0.png");
  strokeWeight(3);
  flemming = new Dyr();
  talHast = height*0.05;
  for (int i=0; i<height/250*2; i++) {
    for (float x=width/40; x<width*0.105; x+=4) {
      bølgePunkter.add(new PVector(x, i+sin(x/10)*height/250));
    }
  }
  vandBølge = -height*0.004;
  matRegnGenstartKnap = new MatRegnGenstartKnap(width/2-width/8, height/4-height/8, width/4, height/4, color(0), color(100), color(0), "Genstart", 100, color(255));
  tilbageKnap = new TilbageKnap(width/2-width/8, height/4*3-height/8, width/4, height/4, color(0), color(100), color(0), "Tilbage", 100, color(255));
}
void draw() {
  delta = (millis()-deltaTime)/1000;
  deltaTime = millis();
  if (sted == hjem) {
    Hjem();
  }
  if (sted == matRegn) {
    MatematikRegn();
    println(point);
  }
  //blink timer
  if (millis()-blinkTimer >= blinkTime*1000) {
    flemming.blink(500);
    blinkTimer = millis();
    blinkTime = random(1, 60);
  }
  for (int i=0; i<knapper.size(); i++) {
    Knap knap = knapper.get(i);
    if (knap.isActive == true) {
      knap.tegnKnap();
    }
  }
}




void mousePressed() {
  //når man trykker på flemming så blinker han
  if (mouseX > flemming.x+flemming.sizeY*tan(flemming.angle)*0.5-camX
    && mouseX < flemming.x+flemming.sizeX+flemming.sizeY*tan(flemming.angle)-flemming.sizeY*tan(flemming.angle)*0.5-camX
    && mouseY > flemming.y-camY && mouseY < flemming.y+flemming.sizeY-camY) {

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
  }
  if (sted == matRegn) {
    if (tutorial) {
      if (side+1 < matRegnSider.length) {
        side += 1;
      } else {
        tutorial = false;
      }
    } else {
      for (int i=0; i<regnTal.size(); i++) {
        if (regnTal.get(i).klik()) {
          if (regnTal.get(i).værdi == tal1+tal2) {
            regnTal.remove(regnTal.get(i));
            for (int z=0; z<regnTal.size(); z++) {
              if (regnTal.get(z).erLøsning) {
                regnTal.get(z).erLøsning = false;
              }
            }
            talTime *= 0.95;
            talHast *= 1.05;
            point += 1;
            if (point % 3 == 0) {
              maxTal += 1;
            }
            tal1 = round(random(1, maxTal));
            tal2 = round(random(1, maxTal));
          } else {
            regnTal.get(i).farve = color(255, 0, 0);
            background(255, 0, 0);
            liv -= 1;
          }
        }
      }
    }
  }
  for (int i=0; i<knapper.size(); i++) {
    Knap knap = knapper.get(i);
    if (knap.isActive == true && knap.musOver()) {
      knap.klik();
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
