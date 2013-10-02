class Grid {
  int cells;
  ArrayList<Point> points;
  
  PImage image;
  
  public Grid(float x, float y, float w, float h, int n) {
    points = new ArrayList<Point>();
    cells = n;
    
    float horizontalSpacing = w / n;
    float verticalSpacing = h / n;
    
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        float pointX = horizontalSpacing * j / (n - 1);
        float pointY = verticalSpacing * i / (n - 1);
        
        points.add(new Point(pointX, pointY));
      }
    }
  }
  
  void drawGrid() {
    for (int i = 0; i < cells - 1; i++) {
      for (int j = 0; j < cells - 1; j++) {        
        getPoint(i, j).lineTo(getPoint(i + 1, j));
        getPoint(i, j).lineTo(getPoint(i, j + 1));
      }
    }
    
    for (int i = 0; i < cells - 1; i++) {
      getPoint(i, cells - 1).lineTo(getPoint(i + 1, cells - 1));
    }
    
    for (int i = 0; i < cells - 1; i++) {
      getPoint(cells - 1, i).lineTo(getPoint(cells - 1, i + 1));
    }
  }
  
  void drawImage() {
    float in = 1.0 / (cells - 1);
    
    textureMode(NORMAL);       // texture parameters in [0,1]x[0,1]
    beginShape(QUADS);
    
    for (int i = 0; i < cells - 1; i++) {
      beginShape(QUAD_STRIP);
      texture(image);
      
      for (int j = 0; j < cells; j++) {
        Point a = getPoint(i, j);
        Point b = getPoint(i + 1, j);
        
        vertex(a.x, a.y, in * j, in * i);
        vertex(b.x, b.y, in * j, in * (i + 1));
      }
      
      endShape();
    }
  }
  
  Point getPoint(int row, int column) {
    int index = row * cells + column;
        
    if (index < points.size()) {
      return points.get(index);
    } else {
      return points.get(points.size() - 1);
    }
  }
}
