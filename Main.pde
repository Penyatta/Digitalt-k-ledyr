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
void mousePressed () {
  if (MadIHånden) {
    MadILuften=true;
    MadIHånden=false;
    mad.GivSlip();
  }
  int ellipseDecider=(((mouseX-width/13*11)^2)/((width/9)^2))+((mouseY-height/20*16)^2)/((height/8)^2);
  if (ellipseDecider<=1&& !MadIHånden) {
    mad = new MadPartikel();
    MadIHånden=true;
  }
}
