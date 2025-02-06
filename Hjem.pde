void Hjem() {
  stroke(0);
  background(100, 50, 50);
  fill(100);
  stroke(0);
  strokeWeight(3);
  rect(-10-camX, height*0.8-camY, width+21, height*0.2);
  flemming.tegnDyr();
  tegnMadDrikke();
  tunge();
  fill(0);
  //rect(width/2-width/8,height/3*2-height/16,width/4,height/4);
  prevX=mouseX;
  prevY=mouseY;
  //camX = lerp(camX, width, 0.001);
}

void skiftTilHjem() {
  sted = hjem;
  camX = 0;
  camY = 0;
  flemming.x = width*0.4;
  flemming.y = height*0.6;
  flemming.sizeX = width/4;
  flemming.sizeY = height/4;
}
