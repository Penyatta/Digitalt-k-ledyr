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
  stroke(255);
  strokeWeight(2);
  beginShape();
  //tegner de individuelle punkter i en stjerne
  vertex(0, -25);
  vertex(7, -10);
  vertex(24, -8);
  vertex(12, 4);
  vertex(15, 20);
  vertex(0, 13);
  vertex(-15, 20);
  vertex(-12, 4);
  vertex(-24, -8);
  vertex(-7, -10);
  endShape(CLOSE); 
}
