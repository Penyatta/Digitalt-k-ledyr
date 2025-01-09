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
  strokeWeight(3);
  flemming = new Dyr();
  frameRate(60);
  //flemming.x = width/8;
  for (float x=width/4; x<width/4*3; x+=5) {
    strokeWeight(3);
    PVector bølgePunkt = new PVector(x, sin(x/20)*20);
    bølgePunkter.add(bølgePunkt);
  }
}
void draw() {
  stroke(0);
  background(100, 50, 50);
  for(int i=0;i<50;i++){
    for(int punkt=0;punkt<bølgePunkter.size();punkt++){
      noStroke();
      fill(0, 0, 255);
      square(bølgePunkter.get(punkt).x, width/10+i+bølgePunkter.get(punkt).y, 5);
    }
  }
  rect(width/4, width/9, width/2, height/10);
  fill(100);
  stroke(0);
  strokeWeight(3);
  rect(-10-camX, height*0.8-camY, width+21, height*0.2);
  flemming.tegnDyr();
  //blink timer
  if (millis()-blinkTimer >= blinkTime*1000) {
    flemming.blink(500);
    blinkTimer = millis();
    blinkTime = random(1, 60);
  }
  tegnMadDrikke();
  tunge();
  fill(0);
  //text(mouseX, 100, 100);
  //text(mouseY, 100, 200);
  //rect(width/2-width/8,height/3*2-height/16,width/4,height/4);
  prevX=mouseX;
  prevY=mouseY;
  //camX = lerp(camX, width, 0.001);
}

void mousePressed() {
  //når man trykker på flemming så blinker han
  if (mouseX > flemming.x+flemming.sY*tan(flemming.angle)*0.5 && mouseX < flemming.x+flemming.sX+flemming.sY*tan(flemming.angle)-flemming.sY*tan(flemming.angle)*0.5 && mouseY > flemming.y && mouseY < flemming.y+flemming.sY) {
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
}
