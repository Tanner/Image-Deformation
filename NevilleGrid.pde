class NevilleGrid {
  Grid a, b, c;
  Grid grid;
  float time;
  
  public NevilleGrid(Grid a, Grid b, Grid c, color col) {
    this.a = a;
    this.b = b;
    this.c = c;
    
    if (a.cells != b.cells && b.cells != c.cells) {
      return;
    }
    
    grid = new Grid(0, 0, 0, 0, a.cells, col);
    
    time = 0;
  }
  
  void drawGrid() {
    // Neville's Curve implementation from Lecture 7 notes page 5 section 3.4.
    for (int row = 0; row < grid.cells; row++) {
      for (int col = 0; col < grid.cells; col++) {
        Point aPoint = a.points[row][col];
        Point bPoint = b.points[row][col];
        Point cPoint = c.points[row][col];
        
        Point firstPoint = aPoint.linearInterpolationToPoint(bPoint.pointByAddingVector(new Vector(aPoint, bPoint)), time);
        Point secondPoint = bPoint.pointByAddingVector(new Vector(cPoint, bPoint)).linearInterpolationToPoint(cPoint, time);
        
        grid.points[row][col] = firstPoint.linearInterpolationToPoint(secondPoint, time);
      }
    }
    
    grid.drawGrid();
  }
  
  void drawImage() {
    grid.drawImage();
  }
}
