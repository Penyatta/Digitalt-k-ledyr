class Dyr {
  String navn;

  float x = width*0.4;
  float y = height*0.6;
  float sX = width/4;
  float sY = height/4;
  float smooth = width/40;
  float angle = -PI/6;

  float pupilXL = 0;
  float pupilYL = 0;
  float pupilXR = 0;
  float pupilYR = 0;

  boolean blink = false;
  float blinkTimer = 0;
  float blinkModifier = 1;

  float timer;

  String humør = "glad";
  float mundVinkel = 0;
  float brynVinkel = 0;
  float brynLængde = sX/30;
  float brynDistance = sX/60;

  float mundPosX;
  float mundPosY;
  float hastTunge=0.3;
  float tungeX=x+sX/6;
  float tungeY=y+sY*0.7;
  boolean tungeIBrug=false;
  boolean tungeUd=true;
  
  boolean drikker = false;
  boolean harDrukket = false;
  boolean flytterTilVand = false;
  
  int dybde=0;
  int dimensionalitet = 2;

  void tegnDyr() {
    float eyeX = x+sX*0.45-camX;
    float eyeY = y+sY*0.2-camY;
    float eyeSX = sX/8;
    float eyeSY = sY/3*blinkModifier;
    float pupilSize = eyeSX/2;
    float pL = eyeX-sX*0.15;
    float pR = eyeX+sX*0.15;
    float dL = atan((mouseY-eyeY)/(mouseX-pL));
    float dR = atan((mouseY-eyeY)/(mouseX-pR));
    float mX = eyeSX/2-pupilSize/2;
    float mY = 0;
    float h = ((2*brynVinkel*(eyeSX/2)*eyeSY)/(pow(eyeSX, 2)*sqrt(1-4*pow(brynVinkel*(eyeSX/2), 2)/pow(eyeSX, 2))));
    float hyp = sqrt(pow(h, 2)+1);
    mundPosX=x+sX/6-camX;
    mundPosY=y+sY*0.7-camY;
    pushMatrix();
    shearX(angle);
    fill(0, 200, 255);
    rect(x-tan(angle)*(y-camY)-camX, y-camY, sX, sY, smooth);
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
    if(tungeIBrug){
      fill(0);
    }
    if(drikker == false){
      arc(x+sX/6-camX, y+sY*0.7-camY, sX/8, sX/8, mundVinkel, PI+mundVinkel);
    }
    else{
      fill(0);
      circle(x+sX/6-camX, y+sY*0.73-camY, sX/16);
    }
    if (eyeSY > pupilSize) {
      mY = eyeSY/2-pupilSize/2;
    }
    if (mouseX-pL < 0) {
      dL+=PI;
    }
    if (mouseX-pL >= 0 && mouseY-eyeY < 0) {
      dL+=2*PI;
    }
    if (mouseX-pR < 0) {
      dR+=PI;
    }
    if (mouseX-pR >= 0 && mouseY-eyeY < 0) {
      dR+=2*PI;
    }
    float pXL = (mX*mY)/sqrt(pow(mY, 2)+pow(mX, 2)*pow(tan(dL), 2));
    if (mouseX-pL < 0) {
      pXL = -pXL;
    }
    float pXR = (mX*mY)/sqrt(pow(mY, 2)+pow(mX, 2)*pow(tan(dR), 2));
    if (mouseX-pR < 0) {
      pXR = -pXR;
    }
    float pYR = tan(dR)*pXR;
    float pYL = tan(dL)*pXL;
    if (degrees(dL) < 90.1 && degrees(dL) > 89.9) {
      pYL = mY;
    }
    if (degrees(dR) < 90.1 && degrees(dR) > 89.9) {
      pYR = mY;
    }
    float rL = sqrt(pow(pXL, 2)+pow(pYL, 2));
    float rR = sqrt(pow(pXR, 2)+pow(pYR, 2));
    if (sqrt(pow(mouseX-pL, 2)+pow(mouseY-eyeY, 2)) < rL) {
      pXL = mouseX-pL;
      pYL = mouseY-eyeY;
    }
    if (sqrt(pow(mouseX-pR, 2)+pow(mouseY-eyeY, 2)) < rR) {
      pXR = mouseX-pR;
      pYR = mouseY-eyeY;
    }
    pupilXL = lerp(pupilXL, pXL, 0.2);
    pupilYL = lerp(pupilYL, pYL, 0.2);
    pupilXR = lerp(pupilXR, pXR, 0.2);
    pupilYR = lerp(pupilYR, pYR, 0.2);
    if (isNan(pupilXL)) {
      pupilXL = mouseX-pL;
    }
    if (isNan(pupilYL)) {
      pupilYL = mouseY-eyeY;
    }
    if (isNan(pupilXR)) {
      pupilXR = mouseX-pR;
    }
    if (isNan(pupilYR)) {
      pupilYR = mouseY-eyeY;
    }
    fill(255);
    ellipse(pL, eyeY, eyeSX, eyeSY);
    ellipse(pR, eyeY, eyeSX, eyeSY);
    fill(0);
    noStroke();
    if (blink == true) {
      blinkModifier = lerp(blinkModifier, 0, 0.6);
    }
    ellipse(pupilXL*blinkModifier+pL, pupilYL*blinkModifier+eyeY, pupilSize, pupilSize*blinkModifier);
    ellipse(pupilXR+pR, pupilYR+eyeY, pupilSize, pupilSize*blinkModifier);
    stroke(0);
    float dY = h/(hyp);
    float dX = sqrt(1-pow(dY, 2));
    float brynX = brynVinkel*((eyeSX+brynDistance*blinkModifier)/2);
    float brynY = -(eyeSY+brynDistance*blinkModifier)/2*sqrt(1-pow(brynX/(eyeSX+brynDistance*blinkModifier)*2, 2));
    line(brynX+pL-dX*brynLængde, brynY+eyeY-dY*brynLængde, brynX+pL+dX*brynLængde, brynY+eyeY+dY*brynLængde);
    line(-brynX+pR-dX*brynLængde, brynY+eyeY+dY*brynLængde, -brynX+pR+dX*brynLængde, brynY+eyeY-dY*brynLængde);
    if (tungeIBrug) {
      stroke(209, 144, 142);
      strokeWeight(10);
      strokeCap(ROUND);
      line(mundPosX+cos(mundVinkel+PI/2)*sX/25, mundPosY+sin(mundVinkel+PI/2)*sX/25, tungeX, tungeY);
      stroke(0);
      strokeWeight(3);
      strokeCap(SQUARE);
    }
    if(flytterTilVand == true){
      x=lerp(x,width/12,0.05);
      y=lerp(y,height/10*6-height/90,0.05);
    }
    if(x < width/12+1 && x > width/12-1 && harDrukket == false){
      drikker = true;
      flytterTilVand = false;
      harDrukket = true;
    }
    if(drikker == false && harDrukket == true){
      x=lerp(x,width*0.4,0.05);
      y=lerp(y,height*0.6,0.05);
      if(x<width*0.4+0.1 && x>width*0.4-0.1 && y<height*0.6+0.1 && y>height*0.6-0.1){
        harDrukket = false;
      }
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
      flemming.tungeX=lerp(flemming.tungeX, flemming.mundPosX+cos(flemming.mundVinkel+PI/2)*flemming.sX/25, flemming.hastTunge);
      flemming.tungeY=lerp(flemming.tungeY, flemming.mundPosY+sin(flemming.mundVinkel+PI/2)*flemming.sX/25, flemming.hastTunge);
      MadPartikler.get(nuværendeMad).posX=flemming.tungeX+camX;
      MadPartikler.get(nuværendeMad).posY=flemming.tungeY+camY;
      if (flemming.tungeX <= flemming.mundPosX+cos(flemming.mundVinkel+PI/2)*flemming.sX/25+1 && flemming.tungeX >= flemming.mundPosX+cos(flemming.mundVinkel+PI/2)*flemming.sX/25-1) {
        flemming.tungeUd=true;
        flemming.tungeIBrug=false;
        MadPartikler.remove(nuværendeMad);
        flemming.dybde+=1;
        if(flemming.dimensionalitet == 2){
          flemming.dimensionalitet += 1;
        }
      }
    }
  }
}
