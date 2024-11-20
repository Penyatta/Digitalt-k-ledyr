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
  rect(0, height*0.8, width, height*0.2);
  flemming.tegnDyr();
  tegnMadDrikke();
  text(mouseX, 100, 100);
  text(mouseY, 100, 200);
  //ellipse(width/13*11,height/20*16,width/9,height/8);
}

void mousePressed () {
  int ellipseDecider=(((mouseX-width/13*11)^2)/((width/9)^2))+((mouseY-height/20*16)^2)/((height/8)^2);
  if (ellipseDecider<=1) {
    MadIHånden=true;
  }
}
