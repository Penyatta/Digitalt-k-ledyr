Dyr flemming;

float NaN = 0.0/0.0;

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
  tegnMadDrikke();
  fill(0);
  text(mouseX, 100, 100);
  text(mouseY, 100, 200);
  //rect(width/2-width/8,height/3*2-height/16,width/4,height/4);
  prevX=mouseX;
  prevY=mouseY;
}
MadPartikel mad;
void mousePressed() {
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
