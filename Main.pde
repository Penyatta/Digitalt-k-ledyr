Dyr flemming;

float blinkTime = random(1, 60);
float blinkTimer = 0;

boolean isNan(float val) {
  return val != val;
}

void setup() {
  fullScreen();
  Madskål=loadImage("Madskål.png");
  strokeWeight(3);
  flemming = new Dyr();
  //flemming.x = width/8;
}
void draw() {
  stroke(0);
  background(100, 50, 50);
  fill(100);
  rect(-10, height*0.8, width+21, height*0.2);
  flemming.tegnDyr();
  if(millis()-blinkTimer >= blinkTime*1000){
    flemming.blink(500);
    blinkTimer = millis();
    blinkTime = random(1, 60);
  }
}

void mousePressed(){
  if(mouseX > flemming.x+flemming.sY*tan(flemming.angle)*0.5 && mouseX < flemming.x+flemming.sX+flemming.sY*tan(flemming.angle)-flemming.sY*tan(flemming.angle)*0.5 && mouseY > flemming.y && mouseY < flemming.y+flemming.sY){
    flemming.blink(500);
  }
  if (MadIHånden) {
        MadIHånden = false; // No longer in hand
        MadPartikler.get(MadPartikler.size()-1).GivSlip(); // Release the food particle
    } else {
        double ellipseDecider = ((Math.pow(mouseX - width / 13 * 11, 2) / Math.pow(width / 9, 2)) + 
                                   (Math.pow(mouseY - height / 20 * 16, 2) / Math.pow(height / 8, 2)));
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
  tegnMadDrikke();
  tunge();
  fill(0);
  text(mouseX, 100, 100);
  text(mouseY, 100, 200);
  //rect(width/2-width/8,height/3*2-height/16,width/4,height/4);
  prevX=mouseX;
  prevY=mouseY;
}
