PImage image;

Grid selectedGrid;
EditMode mode;

Grid baseGrid;
Grid gridOne, gridTwo, gridThree;

void setup() {
  size(600, 600, P3D);
  smooth();
  
  image = loadImage("picture.jpg");
  
  float ratio = (float) image.width / image.height;
  
  float imageHeight = (height / 2);
  float imageWidth = ratio * imageHeight;
  
  baseGrid = new Grid(10, 10, imageWidth, imageHeight, 10, #FF00FB);
  gridOne = new Grid(10, 10, imageWidth, imageHeight, 10, #FF0000);
  gridTwo = new Grid(10, 10, imageWidth, imageHeight, 10, #00FF00);
  gridThree = new Grid(10, 10, imageWidth, imageHeight, 10, #0000FF);
  
  baseGrid.image = image;
  
  selectGrid(baseGrid, true);
  mode = EditMode.EDIT_POINTS;
}

void draw() {
  background(#FFFFFF);
  stroke(#000000);
  fill(#000000);
  
  baseGrid.drawGrid();
  baseGrid.drawImage();
  
  gridOne.drawGrid();
  gridOne.drawImage();
  
  gridTwo.drawGrid();
  gridTwo.drawImage();
  
  gridThree.drawGrid();
  gridThree.drawImage();
}

void mousePressed() {
}

void mouseDragged() {
  if (mode == EditMode.EDIT_POINTS) {
    // Move around an individual point
  } else if (mode == EditMode.TRANSLATE) {
    // Translate the points
    selectedGrid.moveByMouseDelta();
  } else if (mode == EditMode.ROTATE) {
    // Rotate the grid
  } else if (mode == EditMode.SCALE) {
    // Scale the grid
  }
}

void keyPressed() {
  // If key is a number, then it is a grid selection key...
  if (key >= 48 && key <= 57) {
    gridKeyPressed();
  } else {
    // Must be a function (transformation) key
    switch (Character.toLowerCase(key)) {
      case 'e':
        mode = EditMode.EDIT_POINTS;
        break;
      case 't':
        mode = EditMode.TRANSLATE;
        break;
      case 'r':
        mode = EditMode.ROTATE;
        break;
      case 's':
        mode = EditMode.SCALE;
        break;
    }
  }
}

void gridKeyPressed() {
  // Deselect all grids first
  selectGrid(baseGrid, false);
  selectGrid(gridOne, false);
  selectGrid(gridTwo, false);
  selectGrid(gridThree, false);
  
  switch (Character.toLowerCase(key)) {
    case '0':
      selectGrid(baseGrid, true);
      break;
    case '1':
      selectGrid(gridOne, true);
      break;
    case '2':
      selectGrid(gridTwo, true);
      break;
    case '3':
      selectGrid(gridThree, true);
      break;
  }
}

void selectGrid(Grid grid, boolean select) {
  if (select) {
    selectedGrid = grid;
    grid.select();
  } else {
    selectedGrid = null;
    grid.deselect();
  }
}
