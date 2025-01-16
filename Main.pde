Dyr flemming;

float blinkTime = random(1, 60);
float blinkTimer = 0;

float camX = 0;
float camY = 0;

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
  for(int i=0;i<height/250*2;i++){
    for(float x=width/40;x<width*0.105;x+=3){
      bølgePunkter.add(new PVector(x, i+sin(x/10)*height/250));
    }
  }
  vandBølge = -height*0.004;
}
void draw() {
  stroke(0);
  background(100, 50, 50);
  fill(100);
  rect(-10-camX, height*0.8-camY, width+21, height*0.2);
  flemming.tegnDyr();
  if(millis()-blinkTimer >= blinkTime*1000){
    flemming.blink(500);
    blinkTimer = millis();
    blinkTime = random(1, 60);
  }
  tegnMadDrikke();
  tunge();
  fill(0);
  text(flemming.dybde, 100, 100);
  text(flemming.dimensionalitet, 100, 200);
  //rect(width/2-width/8,height/3*2-height/16,width/4,height/4);
  prevX=mouseX;
  prevY=mouseY;
}

void mousePressed(){
  if(mouseX > flemming.x+flemming.sY*tan(flemming.angle)*0.5 && mouseX < flemming.x+flemming.sX+flemming.sY*tan(flemming.angle)-flemming.sY*tan(flemming.angle)*0.5 && mouseY > flemming.y && mouseY < flemming.y+flemming.sY){
    flemming.blink(500);
  }
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

void keyPressed(){
  if(key == 's'){
    flemming.humør = "sur";
  }
  if(key == 'g'){
    flemming.humør = "glad";
  }
  if(key == 't'){
    flemming.humør = "trist";
  }
  if(key == 'd' && flemming.harDrukket == false){
    flemming.flytterTilVand = true;
    flemming.dimensionalitet += 1;
  }
}
