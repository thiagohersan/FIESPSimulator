PGraphics pg;
PImage img, mask;
float fv;
int typeOfFlash;
String serverAddress = "./data/";

void setup() {
  size(600, 480);
  pg = createGraphics(400, 480);
  img = loadImage(serverAddress+"FIESP00_00.png");
  mask = loadImage(serverAddress+"FIESP00_00_mask.png");
  fv = 0;
  typeOfFlash = 0;
}

void mousePressed() {
  flash();
}
void keyPressed() {
  flash();
}

void flash() {
  fv = 1.0;
  typeOfFlash = (int)random(0, 4);
}

void draw() {
  pg.beginDraw();
  pg.background(0);
  pg.pushMatrix();
  pg.translate(pg.width/1.4, pg.height/2);
  if (typeOfFlash == 0) {
    pg.stroke(abs(fv));
    for (int i=0; i<200&&abs(fv)>0.0; i++) {
      float x = random(-200, 200);
      float y = random(-200, 200);
      pg.line(x, y, -x, -y);
    }
  } else if (typeOfFlash == 1) {
    pg.background(abs(fv));
  } else if (typeOfFlash == 2) {
    pg.background(abs(fv));
    pg.stroke(0);
    for (int i=0; i<200&&abs(fv)>0.0; i++) {
      float x = random(-200, 200);
      float y = random(-200, 200);
      pg.line(x, y, -x, -y);
    }
  } else {
    pg.stroke(abs(fv));
    for (int i=0; i<100&&abs(fv)>0.0; i++) {
      float x = random(-40, 40);
      float y = random(-40, 40);
      float rx = random(100, 200);
      float ry = random(100, 200);
      pg.noFill();
      pg.ellipse(x, y, rx, ry);
    }
  }

  pg.popMatrix();
  pg.endDraw();

  pushMatrix();
  scale(0.8);

  if (fv > 0.0) {
    fv += 128.0;
    if (fv >= 255) fv = -255.0;
  } else if (fv < 0.0) {
    fv += 200.0;
    if (fv >= 0.0) {
      fv = 0.0;
    }
  }

  background(0);
  pushMatrix();
  translate(width/2, height/2);
  image(pg, -pg.width/2, -pg.height/2.15);
  tint(255, 128);
  image(img, -img.width/2, -img.height/2.15);
  tint(255, 255);
  image(mask, -mask.width/2, -mask.height/2.15);
  popMatrix();

  popMatrix();
}