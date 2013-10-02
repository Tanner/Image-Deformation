PImage image;

Grid selectedGrid;
Point selectedPoint;
EditMode mode;

Grid baseGrid;
Grid gridOne, gridTwo, gridThree;

final float PADDING = 10;
final int GRID_SIZE = 100;
final int GRID_CELLS = 10;

void setup() {
  size(600, 600, P3D);
  smooth();
  
  image = loadImage("picture.jpg");
  
  baseGrid = new Grid(PADDING, PADDING, GRID_SIZE, GRID_SIZE, GRID_CELLS, #FF00FB);
  gridOne = new Grid(PADDING, PADDING, GRID_SIZE, GRID_SIZE, GRID_CELLS, #FF0000);
  gridTwo = new Grid(PADDING, PADDING, GRID_SIZE, GRID_SIZE, GRID_CELLS, #00FF00);
  gridThree = new Grid(PADDING, PADDING, GRID_SIZE, GRID_SIZE, GRID_CELLS, #0000FF);
  
  baseGrid.image = image;
  gridOne.image = image;
  gridTwo.image = image;
  gridThree.image = image;
  
  selectGrid(baseGrid, true);
  mode = EditMode.EDIT_POINTS;
}

void draw() {
  background(#FFFFFF);
  stroke(#000000);
  fill(#000000);
  
  image(image, PADDING, PADDING);
  
  baseGrid.drawGrid();
  
  gridOne.drawGrid();
  gridOne.drawImage();
  
  gridTwo.drawGrid();
  gridTwo.drawImage();
  
  gridThree.drawGrid();
  gridThree.drawImage();
}

void mousePressed() {
  if (mode == EditMode.EDIT_POINTS && selectedGrid != null) {
    selectedPoint = selectedGrid.getPointClosestToPoint(new Point(mouseX, mouseY));
  }
}

void mouseDragged() {
  if (mode == EditMode.EDIT_POINTS) {
    // Move around an individual point
    selectedPoint.translate(mouseX - pmouseX, mouseY - pmouseY);
  } else if (mode == EditMode.TRANSLATE) {
    // Translate the points
    selectedGrid.moveByMouseDelta();
  } else if (mode == EditMode.ROTATE) {
    // Rotate the grid
    selectedGrid.rotateByMouseDelta();
  } else if (mode == EditMode.SCALE) {
    // Scale the grid
    selectedGrid.scaleByMouseDelta();
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
