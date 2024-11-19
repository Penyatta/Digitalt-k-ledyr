class Dyr{
  String navn;
  String mood;
  
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
  
  void tegnDyr(){
    timer = millis();
    if(timer >= blinkTimer){
      blink = false;
      blinkModifier = lerp(blinkModifier, 1, 0.6);
    }
    pushMatrix();
    shearX(angle);
    fill(0, 200, 255);
    rect(x-tan(angle)*y, y, sX, sY, smooth);
    popMatrix();
    arc(x+sX/6, y+sY*0.7, sX/8, sX/8, PI/8, PI+PI/8);
    float eyeX = x+sX*0.45;
    float eyeY = y+sY*0.2;
    float eyeSX = sX/8;
    float eyeSY = sY/3*blinkModifier;
    float pupilSize = eyeSX/2;
    float pL = eyeX-sX*0.15;
    float pR = eyeX+sX*0.15;
    float dL = atan((mouseY-eyeY)/(mouseX-pL));
    float dR = atan((mouseY-eyeY)/(mouseX-pR));
    float mX = eyeSX/2-pupilSize/2;
    float mY = 0;
    if(eyeSY > pupilSize){
      mY = eyeSY/2-pupilSize/2;
    }
    if(mouseX-pL < 0){
      dL+=PI;
    }
    if(mouseX-pL >= 0 && mouseY-eyeY < 0){
      dL+=2*PI;
    }
    if(mouseX-pR < 0){
      dR+=PI;
    }
    if(mouseX-pR >= 0 && mouseY-eyeY < 0){
      dR+=2*PI;
    }
    float pXL = (mX*mY)/sqrt(pow(mY, 2)+pow(mX, 2)*pow(tan(dL), 2));
    if(mouseX-pL < 0){
      pXL = -pXL;
    }
    float pXR = (mX*mY)/sqrt(pow(mY, 2)+pow(mX, 2)*pow(tan(dR), 2));
    if(mouseX-pR < 0){
      pXR = -pXR;
    }
    float pYR = tan(dR)*pXR;
    float pYL = tan(dL)*pXL;
    if(degrees(dL) < 90.1 && degrees(dL) > 89.9){
      pYL = mY;
    }
    if(degrees(dR) < 90.1 && degrees(dR) > 89.9){
      pYR = mY;
    }
    float rL = sqrt(pow(pXL, 2)+pow(pYL, 2));
    float rR = sqrt(pow(pXR, 2)+pow(pYR, 2));
    if(sqrt(pow(mouseX-pL, 2)+pow(mouseY-eyeY, 2)) < rL){
      pXL = mouseX-pL;
      pYL = mouseY-eyeY;
    }
    if(sqrt(pow(mouseX-pR, 2)+pow(mouseY-eyeY, 2)) < rR){
      pXR = mouseX-pR;
      pYR = mouseY-eyeY;
    }
    pupilXL = lerp(pupilXL, pXL, 0.2);
    pupilYL = lerp(pupilYL, pYL, 0.2);
    pupilXR = lerp(pupilXR, pXR, 0.2);
    pupilYR = lerp(pupilYR, pYR, 0.2);
    if(isNan(pupilXL)){
      pupilXL = mouseX-pL;
    }
    if(isNan(pupilYL)){
      pupilYL = mouseY-eyeY;
    }
    if(isNan(pupilXR)){
      pupilXR = mouseX-pR;
    }
    if(isNan(pupilYR)){
      pupilYR = mouseY-eyeY;
    }
    fill(255);
    ellipse(pL, eyeY, eyeSX, eyeSY);
    ellipse(pR, eyeY, eyeSX, eyeSY);
    fill(0);
    text(blinkModifier, 100, 100);
    noStroke();
    if(blink == true){
      blinkModifier = lerp(blinkModifier, 0, 0.6);
    }
    ellipse(pupilXL*blinkModifier+pL, pupilYL*blinkModifier+eyeY, pupilSize, pupilSize*blinkModifier);
    ellipse(pupilXR+pR, pupilYR+eyeY, pupilSize, pupilSize*blinkModifier);
    stroke(0);
  }
  
  void blink(float time){
    blink = true;
    blinkTimer = millis()+time;
  }
}
