PImage image;
Grid baseGrid;

void setup() {
  size(600, 600, P3D);
  smooth();
  
  image = loadImage("picture.jpg");
  baseGrid = new Grid(0, 0, image.width, image.height, 10);
  
  baseGrid.image = image;
}

void draw() {
  background(#FFFFFF);
  stroke(#000000);
  fill(#000000);
  strokeWeight(3);
  
  baseGrid.drawGrid();
  baseGrid.drawImage();
}

void mousePressed() {
}

void mouseDragged() {
}

void keyPressed() {
  switch (Character.toLowerCase(key)) {
  }
}
