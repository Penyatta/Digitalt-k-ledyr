PImage Madskål;
boolean MadIHånden=false;
boolean MadILuften=false;
float prevX;
float prevY;
ArrayList<MadPartikel> MadPartikler = new ArrayList<MadPartikel>();
int nuværendeMad;

class MadPartikel {
  float Størrelse=height/40;
  float posX=mouseX;
  float posY=mouseY;
  float distanceX;
  float distanceY;
  float hastX=1;
  float hastY=1;
  boolean IHånden=true;
  boolean Stille=false;
  float bouncyness=0.7;
  float vindmodstand=0.9999;
  float gravity=0.8;
  float friktion=0.9;
  void TegnMad() {
    if (IHånden) {
      posX=mouseX+camX;
      posY=mouseY+camY;
    } else if(!Stille){
      if (posX<=Størrelse/2 || posX>=(width-Størrelse/2)) {
        hastX=hastX*(-bouncyness);
        hastY=hastY*(friktion);
        if (posX<width/2) {
          posX= 1+Størrelse/2;
        } else {
          posX=width-1-Størrelse/2;
        }
      }
      if (posY>height-Størrelse/2) {
        hastY=hastY*(-bouncyness);
        hastX=hastX*(friktion);
        posY=height-Størrelse/2;
      }
      if(abs(hastX)<=0.005 && abs(hastY)<=0.4 && posY>height-Størrelse){
       Stille=true; 
      }
      hastX=hastX*vindmodstand;
      hastY=hastY*vindmodstand;
      hastY=hastY+gravity;
      posX=posX+hastX;
      posY=posY+hastY;
    }
    strokeWeight(0);
    fill(154,102,63);
    circle(posX-camX, posY-camY, Størrelse);
    strokeWeight(3);
    distanceX=mouseX-prevX;
    distanceY=mouseY-prevY;
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
  image(Madskål, width/7*5-camX, height/5*3-camY, width/4, height/2);
  for(MadPartikel i : MadPartikler){
    i.TegnMad();
  }
}
