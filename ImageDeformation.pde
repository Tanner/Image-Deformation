PImage image;

void setup() {
  size(600, 600);
  smooth();
  
  image = loadImage("picture.jpg");
}

void draw() {
  background(#FFFFFF);
  stroke(#000000);
  fill(#000000);
  strokeWeight(3);
}

void mousePressed() {
}

void mouseDragged() {
}

void keyPressed() {
  switch (Character.toLowerCase(key)) {
  }
}
