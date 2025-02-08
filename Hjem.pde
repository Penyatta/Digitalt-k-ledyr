void Hjem() {
  stroke(0);
  background(100, 50, 50);
  fill(100);
  stroke(0);
  strokeWeight(3);
  rect(-10-camX, height*0.8-camY, width+width+21, height*0.2);
  tavlen();
  flemming.tegnDyr();
  tegnMadDrikke();
  tunge();
  fill(0);
  //rect(width/2-width/8,height/3*2-height/16,width/4,height/4);
  //bruges til at bestemme hvor langt musen har flyttet sig i den sidste frame til brug i hastigheden til masstykkerne
  prevX=mouseX;
  prevY=mouseY;
  //camX = lerp(camX, width, 0.001);

  if (!flemming.harDrukket && !flemming.flytterTilVand) {
    //pilen til kælderen
    strokeCap(ROUND);
    strokeWeight(10);
    //bestemmer farven af pilen til at bevæge skærm alt efter om musen er ovenoverden
    if (mouseX>width/2-width/20-camX && mouseY>height/30*27-camY && mouseX<width/2+width/20-camX && mouseY<height/15*14-camY) {
      stroke(200);
    } else {
      stroke(150);
    }
    //tegner pilen som man kan trykke på for at skifte skærm
    line(width/2-camX, height/15*14-camY, width/2+width/20-camX, height/30*27-camY);
    line(width/2-camX, height/15*14-camY, width/2-width/20-camX, height/30*27-camY);
    //samme som den ovenover bare for en anden
    if (mouseX>width/20*19-height/30-camX && mouseY>height/2-width/20-camY && mouseX<width/20*19-camX && mouseY<height/2+width/20-camY) {
      stroke(200);
    } else {
      stroke(150);
    }
    line(width/20*19-camX, height/2-camY, width/20*19-height/30-camX, height/2+width/20-camY);
    line(width/20*19-camX, height/2-camY, width/20*19-height/30-camX, height/2-width/20-camY);
    //samme som den ovenover bare for en tredje
    if (mouseX>width/2-width/20-camX && mouseY>2*height-height/15*14-camY && mouseX<width/2+width/20-camX && mouseY<2*height-height/30*27-camY) {
      stroke(200);
    } else {
      stroke(150);
    }
    line(width/2-camX, 2*height-height/15*14-camY, width/2+width/20-camX, 2*height-height/30*27-camY);
    line(width/2-camX, 2*height-height/15*14-camY, width/2-width/20-camX, 2*height-height/30*27-camY);
    //samme som den ovenover bare for en fjerde
    if (mouseX>width/20*21-height/30-camX && mouseY>height/2-width/20-camY && mouseX<width/20*21-camX && mouseY<height/2+width/20-camY) {
      stroke(200);
    } else {
      stroke(150);
    }
    line(width/20*21-camX, height/2+width/20-camY, width/20*21-height/30-camX, height/2-camY);
    line(width/20*21-camX, height/2-width/20-camY, width/20*21-height/30-camX, height/2-camY);
  }
  strokeWeight(3);
  if (rum==legerum && flytterRum) {
    flemming.y=lerp(flemming.y, height*1.72, 0.1);
    flemming.x=lerp(flemming.x, width*0.4, 0.1);
    camY=lerp(camY, height, 0.05);
    camX=lerp(camX, 0, 0.05);
    if (camY>=height-0.1 && camX<=0.1) {
      flytterRum=false;
    }
  }
  if (rum==skinrum && flytterRum) {
    flemming.x=lerp(flemming.x, width*1.4, 0.1);
    flemming.y=lerp(flemming.y, height*0.6, 0.1);
    camY=lerp(camY, 0, 0.05);
    camX=lerp(camX, width, 0.05);
    if (camY<=0.1 && camX>=width-0.1) {
      flytterRum=false;
    }
  }
  if (rum==leverum && flytterRum) {
    flemming.x=lerp(flemming.x, width*0.4, 0.1);
    flemming.y=lerp(flemming.y, height*0.6, 0.1);
    camY=lerp(camY, 0, 0.05);
    camX=lerp(camX, 0, 0.05);
    if (camY<=0.1 && camX<=0.1) {
      flytterRum=false;
    }
  }
}

void tavlen() {
  noStroke();
  fill(168, 116, 42);
  rect(width/10-camX, height/6*7-camY, width/3*2, height/2*1);
  fill(0);
  rect(width/10+width/80-camX, height/6*7+width/80-camY, width/3*2-width/40, height/2*1-width/40);
}

void skiftTilHjem() {
  sted = hjem;
  rum = leverum;
  camX = 0;
  camY = 0;
  flemming.x = width*0.4;
  flemming.y = height*0.6;
  flemming.sizeX = width/4;
  flemming.sizeY = height/4;
}
