ArrayList<Partikel> partikler;

class Partikel {
  float x, y, vx, vy, levetid;

  Partikel(float x, float y) {
    this.x = x;
    this.y = y;
    this.vx = random(-2, 2);
    this.vy = random(-2, 2);
    this.levetid = 255; // Starter med fuld levetid
  }

  void bevæg() {
    x += vx;
    y += vy;
    levetid -= 2;
  }

  void tegn() {
    fill(255, levetid); // Brug alpha til at fade ud
    ellipse(x, y, 10, 10);
  }

  boolean erDød() {
    return levetid <= 0;
  }
}

class Gnister extends Partikel {
  color farve;
  Gnister(float x, float y, color farve) {
    super(x, y);
    this.farve = farve;
  }

  @Override
  void bevæg() {
    super.bevæg();
    vy += 0.1; // Tyngdekraft
  }
  void tegn() {
    noStroke();
    fill(farve, levetid); // Brug alpha til at fade ud
    ellipse(x, y, 10, 10);
  }
}

class Røg extends Partikel {
  Røg(float x, float y) {
    super(x, y);
    this.vx *= 0.5; // Langsommere bevægelse
    this.vy = random(-1, 0);
  }

  @Override
    void tegn() {
    noStroke();
    fill(150, levetid); // Grå farve
    ellipse(x, y, 15, 15);
  }
}

class Hjerte extends Partikel {
  Hjerte(float x, float y) {
    // gør at hjerter kun kan have negativ y hastighed så de stiger
    super(x, y);
    this.vx *= 1;
    this.vy = random(-2, 0);
  }

  @Override
    void tegn() {
    float l = sqrt(pow(vx, 2)+pow(vy, 2))*random(50, 250)*delta;
    vx /= l;
    vy /= l;
    pushMatrix();
    translate(x, y);
    rotate(PI/4);
    noStroke();
    fill(255, 0, 0, levetid);
    //tegner hjertet i den placering translate siger
    rect(0, 0, 10, 10);
    arc(5, 0, 10, 10, PI, 2*PI);
    arc(0, 5, 10, 10, PI/2, PI+PI/2);
    popMatrix();
    stroke(0);
  }
}
