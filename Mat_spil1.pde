class Achivements {
  int maxScore=0;
  //Hvor mange point man skal have for at opnå forskellige stjerner til de forskellige spil
  int bronzeThreshhold, sølvThreshhold, guldThreshhold, authorThreshhold;
  Achivements(int BT,int ST,int GT, int AT){
   bronzeThreshhold=BT;
   sølvThreshhold=ST;
   guldThreshhold=GT;
   authorThreshhold=AT;
  }
}

Achivements matRegnAchivements;
Achivements minusPåVenusAchivements;
Achivements doodlejumpAchivements;

void tegnStjerne(){
  float skalering=width/1920;
  stroke(255);
  strokeWeight(2);
  beginShape();
  //tegner de individuelle punkter i en stjerne
  vertex(0, -25*skalering);
  vertex(7*skalering, -10*skalering);
  vertex(24*skalering, -8*skalering);
  vertex(12*skalering, 4*skalering);
  vertex(15*skalering, 20*skalering);
  vertex(0*skalering, 13*skalering);
  vertex(-15*skalering, 20*skalering);
  vertex(-12*skalering, 4*skalering);
  vertex(-24*skalering, -8*skalering);
  vertex(-7*skalering, -10*skalering);
  endShape(CLOSE); 
}
