class BezierGrid extends Grid {
  Grid grid;
  
  int samplingRate;
    
  public BezierGrid(Grid g, color col) {
    super(0, 0, 0, 0, g.lines, col);
    
    grid = g;
    samplingRate = g.lines;
    
//    textureMappingPoints = grid.textureMappingPoints;
    
    updatePoints();
  }
  
  void updatePoints() {
    Point[][] horizontals = new Point[samplingRate][grid.lines];
    for (int row = 0; row < grid.lines; row++) {
      for (int s = 0; s < samplingRate; s++) {
        Point[] pts = grid.points[row];
        float t = s * (1f / (samplingRate - 1));
        Point point = bezierPoint(pts, t);
                
        horizontals[s][row] = point;
      }
    }
    
    Point[][] verticals = new Point[samplingRate][samplingRate];
    for (int col = 0; col < samplingRate; col++) {
      for (int s = 0; s < samplingRate; s++) {
        Point[] pts = horizontals[col];
        float t = s * (1f / (samplingRate - 1));
        Point point = bezierPoint(pts, t);
                
        verticals[s][col] = point;
      }
    }
    
    this.lines = verticals.length;
    points = verticals;
  }
  
  void setSamplingRate(int r) {
    samplingRate = r;
    
    updatePoints();
  }
}
