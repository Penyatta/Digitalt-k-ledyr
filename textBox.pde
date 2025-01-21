void textBox(String[] sider) {
  fill(255);
  rect(width*0.2, height*0.15, width*0.6, height*0.4, width*0.05);
  fill(0);
  textSize(width*0.03);
  textAlign(CENTER, TOP);
  text(sider[side], width*0.5, height*0.2);
  textSize(width*0.02);
  text(side+1+"/"+sider.length, width*0.75, height*0.5);
}
