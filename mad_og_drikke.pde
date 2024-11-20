PImage Madskål;
boolean MadIHånden=false;
void tegnMadDrikke() {
  image(Madskål, width/7*5, height/5*3, width/4, height/2);
  if (MadIHånden) {
    strokeWeight(0);
    fill(154,102,63);
    circle(mouseX, mouseY, height/40);
    strokeWeight(3);
  }
}
