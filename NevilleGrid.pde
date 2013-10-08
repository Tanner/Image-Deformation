class NevilleGrid {
  Grid a, b, c;
  NormalGrid grid;
  float time;
  
  public NevilleGrid(Grid a, Grid b, Grid c, color col) {
    this.a = a;
    this.b = b;
    this.c = c;
    
    if (a.lines != b.lines && b.lines != c.lines) {
      return;
    }
    
    grid = new NormalGrid(0, 0, 0, 0, a.lines, col);
    
    time = 0;
  }
  
  void drawGrid() {
    grid.drawGrid();
  }
  
  void drawImage(Grid baseGrid, PImage image, boolean drawWithBezierGrid) {
    grid.drawImage(baseGrid, image, drawWithBezierGrid);
  }
  
  void setTime(float t) {
    time = t;
    
    update();
  }
   
  void update() { 
    // Neville's Curve implementation from Lecture 7 notes page 5 section 3.4.
    for (int row = 0; row < grid.lines; row++) {
      for (int col = 0; col < grid.lines; col++) {
        Point aPoint = a.points[row][col];
        Point bPoint = b.points[row][col];
        Point cPoint = c.points[row][col];
        
        Point firstPoint = aPoint.linearInterpolationToPoint(bPoint.pointByAddingVector(new Vector(aPoint, bPoint)), time);
        Point secondPoint = bPoint.pointByAddingVector(new Vector(cPoint, bPoint)).linearInterpolationToPoint(cPoint, time);
        
        grid.points[row][col] = firstPoint.linearInterpolationToPoint(secondPoint, time);
      }
    }
    
    grid.bezierGrid.updatePoints();
  }
}
