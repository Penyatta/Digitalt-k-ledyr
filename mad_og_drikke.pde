PImage Madskål;
boolean MadIHånden=false;
boolean MadILuften=false;
float prevX;
float prevY;

class MadPartikel {
  float Størrelse=height/40;
  float posX=mouseX;
  float posY=mouseY;
  float distanceX;
  float distanceY;
  float hastX=1;
  float hastY=1;
  boolean IHånden=true;
  float bouncyness=0.7;
  float vindmodstand=0.995;
  float gravity=0.1;
  float friktion=0.9;
  void TegnMad() {
    if (IHånden) {
      posX=mouseX;
      posY=mouseY;
    } else {
      if (posX<=Størrelse/2 || posX>=(width-Størrelse/2)) {
        hastX=hastX*(-bouncyness);
        hastY=hastY*(friktion);
        if (posX<width/2) {
          posX= 1+Størrelse/2;
        } else {
          posX=width-1-Størrelse/2;
        }
      }
      if (posY<Størrelse/2) {
        hastY=hastY*(-bouncyness);
        hastX=hastX*(friktion);
        posY=1+Størrelse/2;
      }
      hastX=hastX*vindmodstand;
      hastY=hastY*vindmodstand;
      hastY=hastY+gravity;
      posX=posX+hastX;
      posY=posY+hastY;
    }
    strokeWeight(0);
    fill(154,102,63);
    circle(posX, posY, Størrelse);
    strokeWeight(3);
    distanceX=prevX-mouseX;
    distanceY=prevY-mouseY;
  }
  void GivSlip() {
    if(IHånden){
    IHånden=false;
    hastX=distanceX;
    hastY=distanceY;
    }
  }
}


void tegnMadDrikke() {
  image(Madskål, width/7*5, height/5*3, width/4, height/2);
  if (MadIHånden || MadILuften) {
    mad.TegnMad();
  }
}
