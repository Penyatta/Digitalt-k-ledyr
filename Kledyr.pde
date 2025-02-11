class Dyr {
  String navn;

  //form og placering
  float x = width*0.4;
  float y = height*0.6;
  float sizeX = width/4;
  float sizeY = height/4;
  float smooth = 0.1;
  float angle = -PI/6;

  //den aktuelle position af pupillerne
  float pupilX []= new float[2];
  float pupilY []= new float[2];


  boolean blink = false;
  float blinkTimer = 0;
  float blinkModifier = 1;
  //timer
  float timer;
  //humør
  String humør = "glad";
  float mundVinkel = 0;
  //bryn
  float brynVinkel = 0;

  float mundPosX;
  float mundPosY;
  //tunge
  float hastTunge=10;
  float tungeX=x+sizeX/6;
  float tungeY=y+sizeY*0.7;
  boolean tungeIBrug=false;
  boolean tungeUd=true;

  boolean drikker = false;
  boolean harDrukket = false;
  boolean flytterTilVand = false;

  //VIGTIGT!!! Dybde
  int dybde=0;
  int dimensionalitet = 2;

  void tegnDyr() {
    stroke(0);
    mundPosX=x+sizeX/6-camX;
    mundPosY=y+sizeY*0.7-camY;
    //tegner parralellogrammet
    pushMatrix();
    shearX(angle);
    fill(skinFarver[skin]);
    rect(x-tan(angle)*(y-camY)-camX, y-camY, sizeX, sizeY, smooth*sizeX);
    popMatrix();
    timer = millis();
    //sætter mund og brynvinkel alt efter humør
    if (timer >= blinkTimer) {
      blink = false;
      blinkModifier = lerp(blinkModifier, 1, constrain(20*delta, 0, 1));
    }
    if (humør == "glad") {
      mundVinkel = lerp(mundVinkel, PI/8, constrain(5*delta, 0, 1));
      brynVinkel = lerp(brynVinkel, 0, constrain(5*delta, 0, 1));
    }
    if (humør == "trist") {
      mundVinkel = lerp(mundVinkel, PI+PI/8, constrain(5*delta, 0, 1));
      brynVinkel = lerp(brynVinkel, -0.5, constrain(5*delta, 0, 1));
    }
    if (humør == "sur") {
      mundVinkel = lerp(mundVinkel, PI, constrain(5*delta, 0, 1));
      brynVinkel = lerp(brynVinkel, 0.5, constrain(5*delta, 0, 1));
    }

    øjekonstruktor(0);
    øjekonstruktor(1);

    fill(0, 0, 0, 0);

    //tegner munden alt efter om der drikkes spises eller ingen af delene
    if (tungeIBrug) {
      fill(0);
    }
    if (drikker == false) {
      arc(x+sizeX/6-camX, y+sizeY*0.7-camY, sizeX/8, sizeX/8, mundVinkel, PI+mundVinkel);
    } else {
      fill(0);
      circle(x+sizeX/6-camX, y+sizeY*0.73-camY, sizeX/16);
    }
    //tegner tungen
    if (tungeIBrug) {
      stroke(209, 144, 142);
      strokeWeight(10);
      strokeCap(ROUND);

      line(mundPosX+cos(mundVinkel+PI/2)*sizeX/25, mundPosY+sin(mundVinkel+PI/2)*sizeX/25, tungeX, tungeY);

      stroke(0);
      strokeWeight(3);
      strokeCap(SQUARE);
    }
    //flytter flemming hvis han er på vej mod vand
    if (flytterTilVand == true) {
      x=lerp(x, width/12, constrain(3*delta, 0, 1));
      y=lerp(y, height/10*6-height/90, constrain(3*delta, 0, 1));
    }
    //hvis flemming er ved vandet sætter ham til at drikke
    if (x < width/12+1 && x > width/12-1 && harDrukket == false) {
      drikker = true;
      flytterTilVand = false;
      harDrukket = true;
    }
    // flytter flemming tilbage når den er  færdig med at drikke
    if (drikker == false && harDrukket == true) {
      x=lerp(x, width*0.4, constrain(3*delta, 0, 1));
      y=lerp(y, height*0.6, constrain(3*delta, 0, 1));
      if (x<width*0.4+0.1 && x>width*0.4-0.1 && y<height*0.6+0.1 && y>height*0.6-0.1) {
        harDrukket = false;
      }
    }
  }

  //styrer blink
  void blink(float time) {
    blink = true;
    blinkTimer = millis()+time;
  }
  void blivGlad() {
    humør = "glad";
  }
  void blivTrist() {
    humør = "trist";
  }
  void blivSur() {
    humør = "sur";
  }


  void øjekonstruktor(int RorL) {
    //positionen midt mellem øjnene
    float eyeX = x+sizeX*0.45-camX;
    float eyeY = y+sizeY*0.2-camY;
    //størrelsen af øjnene
    float eyeSizeX = sizeX/8;
    float eyeSizeY = sizeY/3*blinkModifier;
    //Størrelsen af pupilen
    float pupilSize = eyeSizeX/2;
    //hvor meget et øje er skubbet væk fra eyeX og denne er forskellig for de to øjne
    float eyeOffset;
    float brynLængde = sizeX/30;
    float brynDistance = sizeX/60;
    if (RorL==0) {
      eyeOffset=eyeX-sizeX*0.15;
    } else {
      eyeOffset=eyeX+sizeX*0.15;
    }
    //vinklen på øjenbrynene
    float degrees = atan((mouseY-eyeY)/(mouseX-eyeOffset));
    //bruges i pupil følge mus når mus er over øjet
    float mX = eyeSizeX/2-pupilSize/2;
    float mY = 0;
    //højde
    float h = ((2*brynVinkel*(eyeSizeX/2)*eyeSizeY)/(pow(eyeSizeX, 2)*sqrt(1-4*pow(brynVinkel*(eyeSizeX/2), 2)/pow(eyeSizeX, 2))));
    //hypotenusen
    float hyp = sqrt(pow(h, 2)+1);

    if (eyeSizeY > pupilSize) {
      mY = eyeSizeY/2-pupilSize/2;
    }
    if (mouseX-eyeOffset < 0) {
      degrees+=PI;
    }
    if (mouseX-eyeOffset >= 0 && mouseY-eyeY < 0) {
      degrees+=2*PI;
    }
    //positionen i X som en pupil bevæger sig mod
    float pupilMålX = (mX*mY)/sqrt(pow(mY, 2)+pow(mX, 2)*pow(tan(degrees), 2));
    if (mouseX-eyeOffset < 0) {
      pupilMålX = -pupilMålX;
    }
    //positionen i Y som en pupil bevæger sig mod
    float pupilMålY = tan(degrees)*pupilMålX;
    if (degrees(degrees) < 90.1 && degrees(degrees) > 89.9) {
      pupilMålY = mY;
    }
    float r = sqrt(pow(pupilMålX, 2)+pow(pupilMålY, 2));
    if (sqrt(pow(mouseX-eyeOffset, 2)+pow(mouseY-eyeY, 2)) < r) {
      pupilMålX = mouseX-eyeOffset;
      pupilMålY = mouseY-eyeY;
    }
    //bevæger den aktuelle posiition af pupillerne mod mål positionen
    pupilX[RorL] = lerp(pupilX[RorL], pupilMålX, constrain(10*delta, 0, 1));
    pupilY[RorL] = lerp(pupilY[RorL], pupilMålY, constrain(10*delta, 0, 1));
    // hvis positionen er
    if (isNan(pupilX[RorL])) {
      pupilX[RorL] = mouseX-eyeOffset;
    }
    if (isNan(pupilY[RorL])) {
      pupilY[RorL] = mouseY-eyeY;
    }
    fill(255);
    ellipse(eyeOffset, eyeY, eyeSizeX, eyeSizeY);
    fill(0);
    noStroke();
    //hvis den skal blinke lerp
    if (blink == true) {
      blinkModifier = lerp(blinkModifier, 0, constrain(20*delta, 0, 1));
    }
    ellipse(pupilX[RorL]*blinkModifier+eyeOffset, pupilY[RorL]*blinkModifier+eyeY, pupilSize, pupilSize*blinkModifier);
    stroke(0);
    float dY = h/(hyp);
    float dX = sqrt(1-pow(dY, 2));
    //øjenbrynets position
    float brynX = brynVinkel*((eyeSizeX+brynDistance*blinkModifier)/2);
    float brynY = -(eyeSizeY+brynDistance*blinkModifier)/2*sqrt(1-pow(brynX/(eyeSizeX+brynDistance*blinkModifier)*2, 2));
    if (RorL==0) {
      line(brynX+eyeOffset-dX*brynLængde, brynY+eyeY-dY*brynLængde, brynX+eyeOffset+dX*brynLængde, brynY+eyeY+dY*brynLængde);
    } else {
      line(-brynX+eyeOffset-dX*brynLængde, brynY+eyeY+dY*brynLængde, -brynX+eyeOffset+dX*brynLængde, brynY+eyeY-dY*brynLængde);
    }
  }
}

void tunge() {
  // hvis flemming ikke er aktivt ved at spise sætter tunge positionen til at være det rigtige sted
  if (!flemming.tungeIBrug) {
    int i=0;
    flemming.tungeX=flemming.mundPosX+cos(flemming.mundVinkel+PI/2)*flemming.sizeX/25;
    flemming.tungeY=flemming.mundPosY+sin(flemming.mundVinkel+PI/2)*flemming.sizeX/25;
    //hjemmelavet for loop fordi normalt gad ikke virke der tjekker om der er mad som ligger stille
    while (i<MadPartikler.size()) {
      //hvis der er mad som er stille sættes tungen til at være i brug
      if (MadPartikler.get(i).Stille) {
        nuværendeMad=i;
        flemming.tungeIBrug=true;
        break;
      }
      i++;
    }
  } else {
    //når tungen er på vej ud bruger lerp til at få tunge x og y til at nærme sig madens x og y
    if (flemming.tungeUd) {
      flemming.tungeX=lerp(flemming.tungeX, MadPartikler.get(nuværendeMad).posX-camX, constrain(flemming.hastTunge*delta, 0, 1));
      flemming.tungeY=lerp(flemming.tungeY, MadPartikler.get(nuværendeMad).posY-camY, constrain(flemming.hastTunge*delta, 0, 1));
      if (flemming.tungeX<=MadPartikler.get(nuværendeMad).posX+1&&flemming.tungeX>=MadPartikler.get(nuværendeMad).posX-1) {
        flemming.tungeUd=false;
      }
    } else {
      //når tungen er på vej tilbage sætter tungen til at lerp mod sin resting pos
      flemming.tungeX=lerp(flemming.tungeX, flemming.mundPosX+cos(flemming.mundVinkel+PI/2)*flemming.sizeX/25, constrain(flemming.hastTunge*delta, 0, 1));
      flemming.tungeY=lerp(flemming.tungeY, flemming.mundPosY+sin(flemming.mundVinkel+PI/2)*flemming.sizeX/25, constrain(flemming.hastTunge*delta, 0, 1));
      MadPartikler.get(nuværendeMad).posX=flemming.tungeX+camX;
      MadPartikler.get(nuværendeMad).posY=flemming.tungeY+camY;
      //når maden har noget munden resettes booleansne for at der kan spises mere madpartiklen fjernes og der kommer små krummer
      if (flemming.tungeX <= flemming.mundPosX+cos(flemming.mundVinkel+PI/2)*flemming.sizeX/25+1
        && flemming.tungeX >= flemming.mundPosX+cos(flemming.mundVinkel+PI/2)*flemming.sizeX/25-1) {
        flemming.tungeUd=true;
        flemming.tungeIBrug=false;
        MadPartikler.remove(nuværendeMad);
        flemming.dybde+=1;
        for (int i=0; i<10; i++) {
          partikler.add(new Gnister(flemming.tungeX, flemming.tungeY, color(154, 102, 63)));
        }
        if (flemming.dimensionalitet == 2) {
          flemming.dimensionalitet += 1;
        }
      }
    }
  }
}

color[] skinFarver =new color[8];
PImage hængelås;

void loadSkins() {
  //gemmer farverne til de forskellige skins
  skinFarver[0]=color(0, 200, 255);
  skinFarver[1]=color(255, 0, 0);
  skinFarver[2]=color(0, 255, 0);
  skinFarver[3]=color(242, 17, 223);
  skinFarver[4]=color(53, 252, 123);
  skinFarver[5]=color(205, 127, 50);
  skinFarver[6]=color(165, 169, 180);
  skinFarver[7]=color(229, 184, 11);
  //
  hængelås=loadImage("Hængelås.png");
  // opretter knapperne til disse skins
  blåSkinKnap = new VælgSkinKnap(width/2*3, height/12, width/5*2, height/13, color(0), color(0), color(0), "Standard", 50, color(255), 0, 0);
  blåSkinKnap.Reached=true;
  rødSkinKnap = new VælgSkinKnap(width/2*3, height/12, width/5*2, height/13, color(0), color(0), color(0), "Bronze i matematik regn", 50, color(255), 1, 10);
  grønSkinKnap = new VælgSkinKnap(width/2*3, height/12, width/5*2, height/13, color(0), color(0), color(0), "Bronze i minus på venus", 50, color(255), 2, 10);
  pinkSkinKnap = new VælgSkinKnap(width/2*3, height/12, width/5*2, height/13, color(0), color(0), color(0), "Guld i matematik regn", 50, color(255), 3, 30);
  limeSkinKnap = new VælgSkinKnap(width/2*3, height/12, width/5*2, height/13, color(0), color(0), color(0), "Guld i minus på venus ", 50, color(255), 4, 30);
  bronzeSkinKnap = new VælgSkinKnap(width/2*3, height/12, width/5*2, height/13, color(0), color(0), color(0), "Bronze i alt", 50, color(255), 5, 10);
  sølvSkinKnap = new VælgSkinKnap(width/2*3, height/12, width/5*2, height/13, color(0), color(0), color(0), "Sølv i alt", 50, color(255), 6, 20);
  guldSkinKnap = new VælgSkinKnap(width/2*3, height/12, width/5*2, height/13, color(0), color(0), color(0), "Guld i alt ", 50, color(255), 7, 30);
}

void tjekSkins() {
  rødSkinKnap.TjekThreshhold(matRegnAchivements.maxScore);
  pinkSkinKnap.TjekThreshhold(matRegnAchivements.maxScore);
  grønSkinKnap.TjekThreshhold(minusPåVenusAchivements.maxScore);
  limeSkinKnap.TjekThreshhold(minusPåVenusAchivements.maxScore);
  int lavesteMax=matRegnAchivements.maxScore;
  if(minusPåVenusAchivements.maxScore<lavesteMax){
    lavesteMax=minusPåVenusAchivements.maxScore;
  }
  bronzeSkinKnap.TjekThreshhold(lavesteMax);
  sølvSkinKnap.TjekThreshhold(lavesteMax);
  guldSkinKnap.TjekThreshhold(lavesteMax);
}
