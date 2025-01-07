PImage Madskål;
PImage WaterBottle;
boolean MadIHånden=false;
boolean MadILuften=false;
float prevX;
float prevY;
ArrayList<MadPartikel> MadPartikler = new ArrayList<MadPartikel>();
int nuværendeMad;

class MadPartikel {
  float Størrelse=height/random(30,50);
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
  float ground=random(height*0.9,height);
  void TegnMad() {
    
    if (IHånden) {
      //sætter positionen når maden er i hånden
      posX=mouseX+camX;
      posY=mouseY+camY;
    } else if(!Stille){
      //Væg bounce
      if (posX<=Størrelse/2 || posX>=(width-Størrelse/2)) {
        hastX=hastX*(-bouncyness);
        hastY=hastY*(friktion);
        //Sørger for at maden ikke kan være i væggen
        if (posX<width/2) {
          posX= 1+Størrelse/2;
        } else {
          posX=width-1-Størrelse/2;
        }
      }
      //gulv bounce
      if (posY>ground-Størrelse/2) {
        hastY=hastY*(-bouncyness);
        hastX=hastX*(friktion);
        posY=ground-Størrelse/2;
      }
      //hvis den står stille på gulvet sættes denne til true for at spare på processing power
      if(abs(hastX)<=0.005 && abs(hastY)<=0.4 && posY>ground-Størrelse){
       Stille=true; 
      }
      //vindmostand og tyngdekræft
      hastX=hastX*vindmodstand;
      hastY=hastY*vindmodstand;
      hastY=hastY+gravity;
      //ændrer positionen så den flytter sig med hastighed
      posX=posX+hastX;
      posY=posY+hastY;
    }
    //tegner maden
    strokeWeight(0);
    fill(154,102,63);
    circle(posX-camX, posY-camY, Størrelse);
    strokeWeight(3);
    //opdatere distance til brug i hastighed når maden gives slip på
    distanceX=mouseX-prevX;
    distanceY=mouseY-prevY;
  }
  void GivSlip() {
    //giver slip på maden og sætter hastigheden til at være afstanden som musen bevægede sig mellem sidste og nyeste frame
    if(IHånden){
    IHånden=false;
    hastX=distanceX;
    hastY=distanceY;
    }
  }
}


void tegnMadDrikke() {
  //tegner vand ting ting
  image(WaterBottle,width/50-camX, height/7*2-camY,width/9,height/2);
  //laver en arraylist til de madpartikler der skal tegnes foran madskålen
  ArrayList<MadPartikel> dum = new ArrayList<MadPartikel>();
  for(MadPartikel i : MadPartikler){
    if(i.ground < height*0.97){
      //tegner de madpartikler der er bag madskålen
      i.TegnMad();
    }
    else{
      //tilføjer de madpartikler der er foran madskålen til arraylisten
      dum.add(i);
    }
  }
  //tegner madskålen
  image(Madskål, width/7*5-camX, height/5*3-camY, width/4, height/2);
  for(MadPartikel i : dum){
    //tegner madpartiklerne der er foran madskålen
    i.TegnMad();
  }
}
