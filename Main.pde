Dyr flemming;

float blinkTime = random(1, 60);
float blinkTimer = 0;

float camX = 0;
float camY = 0;

//statemachine med hvilken skærm der skal vises
int sted = 0;


int hjem = 0;
int matRegn = 1;

float delta = 0;
float deltaTime = millis();

//statemachine der holder styr på hvilket rum Flemming er i, i huset
int rum=0;

int leverum=0;
int legerum=1;
int skinrum=2;

boolean flytterRum=false;

boolean isNan(float val) {
  return val != val;
}

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
  partikler = new ArrayList<>();
  matRegnGenstartKnap = new MatRegnGenstartKnap(width*0.5-width*0.2, height*0.7-height*0.05, width*0.4, height*0.1, color(100), color(120), color(80), "Genstart", 100, color(255));
  tilbageKnap = new TilbageKnap(width*0.5-width*0.2, height*0.85-height*0.05, width*0.4, height*0.1, color(100), color(120), color(80), "Tilbage", 100, color(255));
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
  for (int i = 0; i < partikler.size(); i++) {
    Partikel p = partikler.get(i);
    p.bevæg();
    p.tegn();
    if (p.erDød()) {
      partikler.remove(i);
    }
  }
  for (int i=0; i<knapper.size(); i++) {
    Knap knap = knapper.get(i);
    if (knap.isActive == true) {
      knap.tegnKnap();
    }
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
  //rect(width/2-width/8,height/3*2-height/16,width/4,height/4);
  //bruges til at bestemme hvor langt musen har flyttet sig i den sidste frame til brug i hastigheden til masstykkerne
  prevX=mouseX;
  prevY=mouseY;
  //camX = lerp(camX, width, 0.001);

  if (!flemming.harDrukket && !flemming.flytterTilVand) {
    //pilen til kælderen
    strokeCap(ROUND);
    strokeWeight(10);
    //bestemmer farven af pilen til at bevæge skærm alt efter om musen er ovenoverden
    if (mouseX>width/2-width/20-camX && mouseY>height/30*27-camY && mouseX<width/2+width/20-camX && mouseY<height/15*14-camY) {
      stroke(200);
    } else {
      stroke(150);
    }
    //tegner pilen som man kan trykke på for at skifte skærm
    line(width/2-camX, height/15*14-camY, width/2+width/20-camX, height/30*27-camY);
    line(width/2-camX, height/15*14-camY, width/2-width/20-camX, height/30*27-camY);
    //samme som den ovenover bare for en anden
    if (mouseX>width/20*19-height/30-camX && mouseY>height/2-width/20-camY && mouseX<width/20*19-camX && mouseY<height/2+width/20-camY) {
      stroke(200);
    } else {
      stroke(150);
    }
    line(width/20*19-camX, height/2-camY, width/20*19-height/30-camX, height/2+width/20-camY);
    line(width/20*19-camX, height/2-camY, width/20*19-height/30-camX, height/2-width/20-camY);
    //samme som den ovenover bare for en tredje
    if (mouseX>width/2-width/20-camX && mouseY>2*height-height/15*14-camY && mouseX<width/2+width/20-camX && mouseY<2*height-height/30*27-camY) {
      stroke(200);
    } else {
      stroke(150);
    }
    line(width/2-camX, 2*height-height/15*14-camY, width/2+width/20-camX, 2*height-height/30*27-camY);
    line(width/2-camX, 2*height-height/15*14-camY, width/2-width/20-camX, 2*height-height/30*27-camY);
    //samme som den ovenover bare for en fjerde
    if (mouseX>width/20*21-height/30-camX && mouseY>height/2-width/20-camY && mouseX<width/20*21-camX && mouseY<height/2+width/20-camY) {
      stroke(200);
    } else {
      stroke(150);
    }
    line(width/20*21-camX, height/2+width/20-camY, width/20*21-height/30-camX, height/2-camY);
    line(width/20*21-camX, height/2-width/20-camY, width/20*21-height/30-camX, height/2-camY);
  }
  strokeWeight(3);
  if (rum==legerum && flytterRum) {
    flemming.y=lerp(flemming.y, height*1.6, 0.1);
    flemming.x=lerp(flemming.x, width*0.4, 0.1);
    camY=lerp(camY, height, 0.05);
    camX=lerp(camX, 0, 0.05);
    if(camY>=height-0.1 && camX<=0.1){
      flytterRum=false;
    }
  }
  if (rum==skinrum && flytterRum) {
    flemming.x=lerp(flemming.x, width*1.4, 0.1);
    flemming.y=lerp(flemming.y, height*0.6, 0.1);
    camY=lerp(camY, 0, 0.05);
    camX=lerp(camX, width, 0.05);
    if(camY<=0.1 && camX>=width-0.1){
      flytterRum=false;
    }
  }
  if (rum==leverum && flytterRum) {
    flemming.x=lerp(flemming.x, width*0.4, 0.1);
    flemming.y=lerp(flemming.y, height*0.6, 0.1);
    camY=lerp(camY, 0, 0.05);
    camX=lerp(camX, 0, 0.05);
    if(camY<=0.1 && camX<=0.1){
      flytterRum=false;
    }
  }
}



void mousePressed() {
  //når man trykker på flemming så blinker han
  if (mouseX > flemming.x+flemming.sizeY*tan(flemming.angle)*0.5-camX
    && mouseX < flemming.x+flemming.sizeX+flemming.sizeY*tan(flemming.angle)-flemming.sizeY*tan(flemming.angle)*0.5-camX
    && mouseY > flemming.y-camY && mouseY < flemming.y+flemming.sizeY-camY) {

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
    if (!flemming.harDrukket && !flemming.flytterTilVand) {
      if (mouseX>width/2-width/20-camX && mouseY>height/30*27-camY && mouseX<width/2+width/20-camX && mouseY<height/15*14-camY) {
        rum=legerum;
        flytterRum=true;
      }
      if (mouseX>width/20*19-height/30-camX && mouseY>height/2-width/20-camY && mouseX<width/20*19-camX && mouseY<height/2+width/20-camY) {
        rum=skinrum;
        flytterRum=true;
      }
      if (mouseX>width/2-width/20-camX && mouseY>2*height-height/15*14-camY && mouseX<width/2+width/20-camX && mouseY<2*height-height/30*27-camY) {
        rum=leverum;
        flytterRum=true;
      }
      if (mouseX>width/20*21-height/30-camX && mouseY>height/2-width/20-camY && mouseX<width/20*21-camX && mouseY<height/2+width/20-camY) {
        rum=leverum;
        flytterRum=true;
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
            flemming.humør = "glad";
            if (point % 3 == 0) {
              maxTal += 1;
            }
            tal1 = round(random(1, maxTal));
            tal2 = round(random(1, maxTal));
          } else {
            flemming.humør = "sur";
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
  if (key == 'd' && flemming.harDrukket == false && sted == hjem && !flytterRum) {
    flemming.flytterTilVand = true;
    flemming.dimensionalitet += 1;
  }

  if (key == 'p') {
    flemming.sizeY *= 0.5;
    flemming.sizeX *= 0.5;
  }
}
