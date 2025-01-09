class Dyr {
  String navn;

  float x = width*0.4;
  float y = height*0.6;
  float sizeX = width/4;
  float sizeY = height/4;
  float smooth = width/40;
  float angle = -PI/6;
  //den aktuelle position af pupillerne
  float pupilX []= new float[2];
  float pupilY []= new float[2];

  boolean blink = false;
  float blinkTimer = 0;
  float blinkModifier = 1;

  float timer;

  String humør = "glad";
  float mundVinkel = 0;
  float brynVinkel = 0;
  float brynLængde = sizeX/30;
  float brynDistance = sizeX/60;

  float mundPosX;
  float mundPosY;
  float hastTunge=0.3;
  float tungeX=x+sizeX/6;
  float tungeY=y+sizeY*0.7;
  boolean tungeIBrug=false;
  boolean tungeUd=true;
  float dybde=1;

  void tegnDyr() {
    mundPosX=x+sizeX/6-camX;
    mundPosY=y+sizeY*0.7-camY;
    pushMatrix();
    shearX(angle);
    fill(0, 200, 255);
    rect(x-tan(angle)*(y-camY)-camX, y-camY, sizeX, sizeY, smooth);
    popMatrix();
    timer = millis();
    if (timer >= blinkTimer) {
      blink = false;
      blinkModifier = lerp(blinkModifier, 1, 0.6);
    }
    if (humør == "glad") {
      mundVinkel = lerp(mundVinkel, PI/8, 0.2);
      brynVinkel = lerp(brynVinkel, 0, 0.2);
    }
    if (humør == "trist") {
      mundVinkel = lerp(mundVinkel, PI+PI/8, 0.2);
      brynVinkel = lerp(brynVinkel, -0.5, 0.2);
    }
    if (humør == "sur") {
      mundVinkel = lerp(mundVinkel, PI, 0.2);
      brynVinkel = lerp(brynVinkel, 0.5, 0.2);
    }
    øjekonstruktor(0);
    øjekonstruktor(1);
    fill(0,200,255);
    if(tungeIBrug){
      fill(0);
    }
    arc(x+sizeX/6-camX, y+sizeY*0.7-camY, sizeX/8, sizeX/8, mundVinkel, PI+mundVinkel);
    if (tungeIBrug) {
      stroke(209, 144, 142);
      strokeWeight(10);
      strokeCap(ROUND);
      line(mundPosX+cos(mundVinkel+PI/2)*sizeX/25, mundPosY+sin(mundVinkel+PI/2)*sizeX/25, tungeX, tungeY);
      stroke(0);
      strokeWeight(3);
      strokeCap(SQUARE);
    }
  }

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


void øjekonstruktor(int RorL){
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
    if(RorL==0){
     eyeOffset=eyeX-sizeX*0.15;
    }
    else{
      eyeOffset=eyeX+sizeX*0.15;
    }
    //vinklen på øjenbrynene
    float degrees = atan((mouseY-eyeY)/(mouseX-eyeOffset));
    float mX = eyeSizeX/2-pupilSize/2;
    float mY = 0;
    float h = ((2*brynVinkel*(eyeSizeX/2)*eyeSizeY)/(pow(eyeSizeX, 2)*sqrt(1-4*pow(brynVinkel*(eyeSizeX/2), 2)/pow(eyeSizeX, 2))));
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
    pupilX[RorL] = lerp(pupilX[RorL], pupilMålX, 0.2);
    pupilY[RorL] = lerp(pupilY[RorL], pupilMålY, 0.2);
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
      blinkModifier = lerp(blinkModifier, 0, 0.6);
    }
    ellipse(pupilX[RorL]*blinkModifier+eyeOffset, pupilY[RorL]*blinkModifier+eyeY, pupilSize, pupilSize*blinkModifier);
    stroke(0);
    float dY = h/(hyp);
    float dX = sqrt(1-pow(dY, 2));
    //øjenbrynets position
    float brynX = brynVinkel*((eyeSizeX+brynDistance*blinkModifier)/2);
    float brynY = -(eyeSizeY+brynDistance*blinkModifier)/2*sqrt(1-pow(brynX/(eyeSizeX+brynDistance*blinkModifier)*2, 2));
    if(RorL==0){
    line(brynX+eyeOffset-dX*brynLængde, brynY+eyeY-dY*brynLængde, brynX+eyeOffset+dX*brynLængde, brynY+eyeY+dY*brynLængde);
    }
    else{
    line(-brynX+eyeOffset-dX*brynLængde, brynY+eyeY+dY*brynLængde, -brynX+eyeOffset+dX*brynLængde, brynY+eyeY-dY*brynLængde);
    }
}
}

void tunge() {
  if (!flemming.tungeIBrug) {
    int i=0;
    while (i<MadPartikler.size()) {
      if (MadPartikler.get(i).Stille) {
        nuværendeMad=i;
        flemming.tungeIBrug=true;
        break;
      }
      i++;
    }
  } else {
    if (flemming.tungeUd) {
      flemming.tungeX=lerp(flemming.tungeX, MadPartikler.get(nuværendeMad).posX-camX, flemming.hastTunge);
      flemming.tungeY=lerp(flemming.tungeY, MadPartikler.get(nuværendeMad).posY-camY, flemming.hastTunge);
      if (flemming.tungeX<=MadPartikler.get(nuværendeMad).posX+1-camX&&flemming.tungeX>=MadPartikler.get(nuværendeMad).posX-1-camX) {
        flemming.tungeUd=false;
      }
    } else {
      flemming.tungeX=lerp(flemming.tungeX, flemming.mundPosX+cos(flemming.mundVinkel+PI/2)*flemming.sizeX/25, flemming.hastTunge);
      flemming.tungeY=lerp(flemming.tungeY, flemming.mundPosY+sin(flemming.mundVinkel+PI/2)*flemming.sizeX/25, flemming.hastTunge);
      MadPartikler.get(nuværendeMad).posX=flemming.tungeX+camX;
      MadPartikler.get(nuværendeMad).posY=flemming.tungeY+camY;
      if (flemming.tungeX <= flemming.mundPosX+cos(flemming.mundVinkel+PI/2)*flemming.sizeX/25+1 
      && flemming.tungeX >= flemming.mundPosX+cos(flemming.mundVinkel+PI/2)*flemming.sizeX/25-1) {
        flemming.tungeUd=true;
        flemming.tungeIBrug=false;
        MadPartikler.remove(nuværendeMad);
        flemming.dybde+=1;
      }
    }
  }
}
