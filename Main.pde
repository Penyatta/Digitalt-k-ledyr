Dyr flemming;

void setup(){
  fullScreen();
  strokeWeight(3);
  flemming = new Dyr();
}
void draw(){
  background(100, 50, 50);
  fill(100);
  rect(0, height*0.8, width, height*0.2);
  flemming.tegnDyr();
}