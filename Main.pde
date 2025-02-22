Dyr flemming;

float blinkTime = random(1, 60);
float blinkTimer = 0;

float camX = 0;
float camY = 0;

//statemachine med hvilken skærm der skal vises
int sted = 0;

int hjem = 0;
int matRegn = 1;
int minusVenus = 2;

float delta = 0;
float deltaTime = millis();

//statemachine der holder styr på hvilket rum Flemming er i, i huset
int rum=0;

int leverum=0;
int legerum=1;
int skinrum=2;

//Holder styr på hvilket skin som flemming bruger
int skin=0;

boolean flytterRum=false;

JSONObject highscores;

boolean isNan(float val) {
  return val != val;
}

ArrayList<PVector> bølgePunkter = new ArrayList<PVector>();

boolean tutorial = true;
int side = 0;
int point = 0;
int liv = 3;

void setup() {
  highscores = loadJSONObject("data/highscores.json");
  if(highscores == null){
    highscores = new JSONObject();
    highscores.setInt("Matematik Regn highscore", 0);
    highscores.setInt("Minus På Venus highscore", 0);
    saveJSONObject(highscores, "data/highscores.json");
  }
  fullScreen();
  frameRate(100);
  Madskål=loadImage("Madskål.png");
  WaterBottle=loadImage("HamsterWater5.0.png");
  matRegnAchivements = new Achivements(10, 20, 30, 57, highscores.getInt("Matematik Regn highscore"));
  minusPåVenusAchivements = new Achivements(10, 20, 30, 53, highscores.getInt("Minus På Venus highscore"));
  loadSkins();
  boulderSize = width*0.05;
  boulderOffset = width;
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

  //sætter parametrene til alle knapperne
  matRegnGenstartKnap = new MatRegnGenstartKnap(width*0.5-width*0.2, height*0.7-height*0.05, width*0.4, height*0.1, color(100), color(120), color(80), "Genstart", 100, color(255));
  minusVenusGenstartKnap = new MinusVenusGenstartKnap(width*0.5-width*0.2, height*0.7-height*0.05, width*0.4, height*0.1, color(100), color(120), color(80), "Genstart", 100, color(255));
  tilbageKnap = new TilbageKnap(width*0.5-width*0.2, height*0.85-height*0.05, width*0.4, height*0.1, color(100), color(120), color(80), "Tilbage", 100, color(255));

  matRegnStartKnap = new MatRegnStartKnap(width/10+width/80, height/6*7+width/80, width/3*2-width/40, height/10-width/200, color(0), color(20), color(40), "Matematik regn", 50, color(255));
  minusPåVenusStartKnap = new MinusPåVenusStartKnap(width/10+width/80, height/6*7+width/80+height/10-width/200, width/3*2-width/40, height/10-width/200, color(0), color(20), color(40), "Minus På Venus", 50, color(255));
  gangeMedLangeKnap = new Knap(width/10+width/80, height/6*7+width/80+(height/10-width/200)*2, width/3*2-width/40, height/10-width/200, color(0), color(20), color(40), "Gange Med Lange - comming never", 50, color(255));
  påMissionMedDivisionKnap = new Knap(width/10+width/80, height/6*7+width/80+(height/10-width/200)*3, width/3*2-width/40, height/10-width/200, color(0), color(20), color(40), "På mission med division - comming never", 50, color(255));
  doodlejumpStartKnap = new Knap(width/10+width/80, height/6*7+width/80+(height/10-width/200)*4, width/3*2-width/40, height/10-width/200, color(0), color(20), color(40), "Hop med Bob - comming never", 50, color(255));
  //sætter hvor mange point man skal have for at få de forskellige stjerner
}
void draw() {
  //sætter delta som bruges til at sørge for at programmet kører på samme måde uanset framerate
  delta = (millis()-deltaTime)/1000;
  deltaTime = millis();
  //tjekker hvor man er henne og kører den relevante funktion
  if (sted == hjem) {
    Hjem();
  } else if (sted == matRegn) {
    MatematikRegn();
  } else if (sted == minusVenus) {
    MinusVenus();
  }
  //blink timer
  if (millis()-blinkTimer >= blinkTime*1000) {
    flemming.blink(500);
    blinkTimer = millis();
    blinkTime = random(1, 60);
  }
  //kører alle partiklernes funktioner igennem
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

void exit(){
  saveJSONObject(highscores, "data/highscores.json");
}

void mousePressed() {
  //når man trykker på flemming så blinker han og der kommer hjerter
  if (mouseX > flemming.x+flemming.sizeY*tan(flemming.angle)*0.5-camX
    && mouseX < flemming.x+flemming.sizeX+flemming.sizeY*tan(flemming.angle)-flemming.sizeY*tan(flemming.angle)*0.5-camX
    && mouseY > flemming.y-camY && mouseY < flemming.y+flemming.sizeY-camY) {

    flemming.blink(500);
    for (int i = 0; i < 3; i++) {
      partikler.add(new Hjerte(mouseX, mouseY));
    }
  }
  //når man trykker på vandunken drikker flemming
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
    //flytter flemming til legerummet hvis pilen trykkes på og aktivere knapperne
    if (!flemming.harDrukket && !flemming.flytterTilVand) {
      if (mouseX>width/2-width/20-camX && mouseY>height/30*27-camY && mouseX<width/2+width/20-camX && mouseY<height/15*14-camY) {
        rum=legerum;
        flytterRum=true;
        slukTændSpilKnapper(true);
      }
      //flytter flemming til skinrummet hvis pilen trykkes på og aktivere knapperne
      if (mouseX>width/20*19-height/30-camX && mouseY>height/2-width/20-camY && mouseX<width/20*19-camX && mouseY<height/2+width/20-camY) {
        rum=skinrum;
        flytterRum=true;
        enableSkins();
        tjekSkins();
      }
      //flytter flemming til leverummet hvis pilen trykkes på og aktivere knapperne
      if (mouseX>width/2-width/20-camX && mouseY>2*height-height/15*14-camY && mouseX<width/2+width/20-camX && mouseY<2*height-height/30*27-camY) {
        rum=leverum;
        flytterRum=true;
      }
      //flytter flemming til leverummet hvis pilen trykkes på og aktivere knapperne
      if (mouseX>width/20*21-height/30-camX && mouseY>height/2-width/20-camY && mouseX<width/20*21-camX && mouseY<height/2+width/20-camY) {
        rum=leverum;
        flytterRum=true;
      }
    }
  }
  //gør man kan trykke igennem tutorial siderne
  if (sted == matRegn) {
    if (tutorial) {
      if (side+1 < matRegnSider.length) {
        side += 1;
      } else {
        tutorial = false;
      }
    } else {
      //tjekker om man trykker på tallene i mat regn
      for (int i=0; i<regnTal.size(); i++) {
        if (regnTal.get(i).klik()) {
          if (regnTal.get(i).værdi == tal1+tal2) {
            regnTal.remove(regnTal.get(i));
            for (int z=0; z<regnTal.size(); z++) {
              if (regnTal.get(z).erLøsning) {
                regnTal.get(z).erLøsning = false;
              }
            }
            //gør spillet svære ved at forøge hastigheden
            talTime *= 0.95;
            talHast *= 1.05;
            point += 1;
            flemming.humør = "glad";
            //sætter max tallet for tallene der kan indgå i plus stykket en højere hver tredje point
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

  if (sted == minusVenus) {
    if (tutorial) {
      if (side+1 < minusVenusSider.length) {
        side += 1;
      } else {
        tutorial = false;
        flemming.x = -width;
      }
    } else if (liv>0 && hulSamlingen != null) {
      if (hulSamlingen.samling1.musOver() && !ruller) {
        ruller = true;
        for (Hul hul : hulSamlingen.samling1.huller) {
          int i = round(random(0, boulders.size()-1));
          while (boulders.get(i).hul != null) {
            i = round(random(0, boulders.size()-1));
          }
          hul.sten = boulders.get(i);
          boulders.get(i).hul = hul;
        }
        valgteHulSamling = hulSamlingen.samling1;
      } else if (hulSamlingen.samling2.musOver() && !ruller) {
        ruller = true;
        for (Hul hul : hulSamlingen.samling2.huller) {
          int i = round(random(0, boulders.size()-1));
          while (boulders.get(i).hul != null) {
            i = round(random(0, boulders.size()-1));
          }
          hul.sten = boulders.get(i);
          boulders.get(i).hul = hul;
        }
        valgteHulSamling = hulSamlingen.samling2;
      }
    }
  }
  //tjekker om man trykker på en knap
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
  /*
  if (key == 'p') {
   flemming.sizeY *= 0.5;
   flemming.sizeX *= 0.5;
   }
   */
}
