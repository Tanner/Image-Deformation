class BezierGrid extends Grid {
  Grid grid;
  
  int samplingRate;
    
  public BezierGrid(Grid g, color col) {
    super(0, 0, 0, 0, g.lines, col);
    
    grid = g;
    samplingRate = g.lines;
    
    updatePoints();
  }
  
  void updatePoints() {    
    for (int row = 0; row < grid.lines; row++) {
      for (int s = 0; s < grid.lines; s++) {
        Point[] pts = grid.points[row];
        float t = s * (1f / (grid.lines - 1));
        Point point = bezierPoint(pts[0], pts[1], pts[2], pts[3], pts[4], t);
                
        points[row][s] = point;
      }
    }
  }
  
  void setSamplingRate(int r) {
    samplingRate = r;
    
    updatePoints();
  }
}
