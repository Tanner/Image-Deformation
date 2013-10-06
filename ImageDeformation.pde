PImage image;

Grid selectedGrid;
Point selectedPoint;
EditMode mode;

Grid baseGrid;
Grid gridOne, gridTwo, gridThree;
NevilleGrid nevilleGrid;

boolean drawGrid;
boolean drawImage;
boolean drawKeyframe;

int bezierSamplingRate;
boolean drawBezierGrid;
boolean mapImageUsingBezier;

final float PADDING = 10;
final int GRID_SIZE = 100;
final int GRID_LINES = 11; // Number of cells is GRID_LINES - 1

void setup() {
  size(600, 600, P3D);
  smooth();
  
  image = loadImage("picture.jpg");
  
  drawGrid = true;
  drawImage = true;
  drawKeyframe = true;
  
  bezierSamplingRate = GRID_LINES - 1;
  drawBezierGrid = false;
  mapImageUsingBezier = false;
  
  float x = PADDING;
  float y = PADDING;
  
  baseGrid = new Grid(x, y, GRID_SIZE, GRID_SIZE, GRID_LINES, #FF00FB);
  
  x += image.width + PADDING;
  
  gridOne = new Grid(x, y, GRID_SIZE, GRID_SIZE, GRID_LINES, #FF0000);
  
  y += GRID_SIZE + PADDING;
  
  gridTwo = new Grid(x, y, GRID_SIZE, GRID_SIZE, GRID_LINES, #00FF00);
  
  y += GRID_SIZE + PADDING;
  
  gridThree = new Grid(x, y, GRID_SIZE, GRID_SIZE, GRID_LINES, #0000FF);
  
  baseGrid.image = image;
  gridOne.image = image;
  gridTwo.image = image;
  gridThree.image = image;
  
  nevilleGrid = new NevilleGrid(gridOne, gridTwo, gridThree, #DDDDDD);
  nevilleGrid.grid.image = image;
  
  selectGrid(baseGrid, true);
  mode = EditMode.EDIT_POINTS;
}

void draw() {
  background(#FFFFFF);
  stroke(#000000);
  fill(#000000);

  image(image, PADDING, PADDING);
  
  Point[][] points = textureMappingPoints(baseGrid, image);
  gridOne.textureMappingPoints = points;
  gridTwo.textureMappingPoints = points;
  gridThree.textureMappingPoints = points;
  
  nevilleGrid.grid.textureMappingPoints = points;

  if (mode == EditMode.ANIMATION) {
    nevilleGrid.setTime((nevilleGrid.time + 0.01 ) % 1.0);
  }

  if (drawImage) {
    gridOne.drawImage();
    gridTwo.drawImage();
    gridThree.drawImage();
    
    if (drawKeyframe) {
      nevilleGrid.drawImage();
    }
  }

  if (drawGrid) {
    baseGrid.drawGrid();
    gridOne.drawGrid();
    gridTwo.drawGrid();
    gridThree.drawGrid();
    
    if (drawKeyframe) {
      nevilleGrid.drawGrid();
    }
  }
}

Point[][] textureMappingPoints(Grid grid, PImage image) {
  Point[][] points = new Point[grid.lines][grid.lines];

  for (int row = 0; row < grid.lines; row++) {
    for (int col = 0; col < grid.lines; col++) {
      Point point = grid.points[row][col];
      
      float x = map(point.x, PADDING, PADDING + image.width, 0.0, 1.0);
      float y = map(point.y, PADDING, PADDING + image.height, 0.0, 1.0);
  
      points[row][col] = new Point(x, y);
    }
  }

  return points;
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
  } else if (mode == EditMode.TIME_SHIFT) {
    // Change the time for the Neville curve
    nevilleGrid.setTime(nevilleGrid.time + 2.0 * float(mouseX - pmouseX) / width);
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
    case '=':
      if (selectedGrid != null) {
        selectedGrid.setShape(baseGrid);
      }
      break;
    case '.':
      mode = EditMode.TIME_SHIFT;
      break;
    case 'a':
      mode = EditMode.ANIMATION;
      break;
    case 'g':
      drawGrid = !drawGrid;
      break;
    case 'p':
      drawImage = !drawImage;
      break;
    case 'k':
      drawKeyframe = !drawKeyframe;
      break;
    case '+':
      bezierSamplingRate++;
      break;
    case '-':
      bezierSamplingRate--;
      break;
    case 'm':
      drawBezierGrid = !drawBezierGrid;
      break;
    case 'u':
      mapImageUsingBezier = !mapImageUsingBezier;
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

