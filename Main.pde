Dyr flemming;

float blinkTime = random(1, 60);
float blinkTimer = 0;

boolean isNan(float val){
  return val != val;
}

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
}
