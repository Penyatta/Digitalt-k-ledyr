ArrayList<Partikel> partikler;

class Partikel {
  float x, y, vx, vy, levetid;

  Partikel(float x, float y) {
    this.x = x;
    this.y = y;
    this.vx = random(-1, 1);
    this.vy = random(-1, 1);
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
  Gnister(float x, float y) {
    super(x, y);
  }

  @Override
    void bevæg() {
    super.bevæg();
    vy += 0.1; // Tyngdekraft
  }
  void tegn() {
    noStroke();
    super.tegn();
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
    super(x, y);
    this.vx *= 0.5; 
    this.vy = random(-1,0);
  }

  @Override
    void tegn() {
    pushMatrix();
    translate(x, y);
    rotate(PI/4);
    noStroke();
    fill(255, 0, 0, levetid);
    rect(0, 0, 10, 10);
    arc(5, 0, 10, 10,PI,2*PI);
    arc(0, 5, 10, 10,PI/2,PI+PI/2);
    popMatrix();
  }
}
