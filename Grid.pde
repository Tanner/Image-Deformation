class Grid {
  int cells;
  Point[][] points;
  boolean selected;
  
  color c;
  PImage image;
  
  public Grid(float x, float y, float w, float h, int n, color c) {
    points = new Point[n][n];
    cells = n;
    this.c = c;
    
    float horizontalSpacing = w / (n - 1);
    float verticalSpacing = h / (n - 1);
        
    for (int row = 0; row < n; row++) {
      for (int col = 0; col < n; col++) {        
        float pointX = horizontalSpacing * col + x;
        float pointY = verticalSpacing * row + y;
        
        points[row][col] = new Point(pointX, pointY);
      }
    }
  }
  
  void drawGrid() {
    if (selected) {
      strokeWeight(3);
    } else {
      strokeWeight(1);
    }
    
    stroke(c);
    for (int row = 0; row < cells; row++) {
      for (int col = 0; col < cells; col++) {
        int nextRow = row + 1 < cells ? row + 1 : 0;
        int nextCol = col + 1 < cells ? col + 1 : 0;
        
        points[row][col].lineTo(points[nextRow][col]);
        points[row][col].lineTo(points[row][nextCol]);
      }
    }
    
    for (int row = 0; row < cells - 1; row++) {
      int nextRow = row + 1 < cells ? row + 1 : 0;
      
      points[row][cells - 1].lineTo(points[nextRow][cells - 1]);
    }
    
    for (int col = 0; col < cells - 1; col++) {
      int nextCol = col + 1 < cells ? col + 1 : 0;
      
      points[cells - 1][col].lineTo(points[cells - 1][nextCol]);
    }
  }
  
  void drawImage() {
    float in = 1.0 / (cells - 1);
    
    textureMode(NORMAL);       // texture parameters in [0,1]x[0,1]
    beginShape(QUADS);
    
    for (int row = 0; row < cells - 1; row++) {
      beginShape(QUAD_STRIP);
      texture(image);
      
      for (int col = 0; col < cells; col++) {
        Point a = points[row][col];
        Point b = points[row + 1][col];
        
        vertex(a.x, a.y, in * col, in * row);
        vertex(b.x, b.y, in * col, in * (row + 1));
      }
      
      endShape();
    }
  }
  
  void moveByMouseDelta() {
    for (int row = 0; row < cells; row++) {
      for (int col = 0; col < cells; col++) {  
        points[row][col].translate(mouseX - pmouseX, mouseY - pmouseY);
      }
    }
  }
  
  void rotateByMouseDelta() {
    Point centroid = centroidOfPoints(points);
    
    float angle = new Vector(centroid, new Point(mouseX, mouseY)).angle(new Vector(centroid, new Point(pmouseX, pmouseY)));
    
    for (int row = 0; row < cells; row++) {
      for (int col = 0; col < cells; col++) {
        points[row][col].rotateAroundPoint(angle, centroid);
      }
    }
  }
  
  void scaleByMouseDelta() {
    Point centroid = centroidOfPoints(points);
    float centroidToMouseDistance = centroid.distance(new Point(mouseX, mouseY));
    float centroidToPastMouseDistance = centroid.distance(new Point(pmouseX, pmouseY));
    float scale = (centroidToPastMouseDistance - centroidToMouseDistance) / centroidToPastMouseDistance;
    
    for (int row = 0; row < cells; row++) {
      for (int col = 0; col < cells; col++) {
        points[row][col].scaleAroundPoint(scale, centroid);
      }
    }
  }
  
  Point getPointClosestToPoint(Point c) {
    Point closestPoint = null;
    float closestPointDistance = Float.MAX_VALUE;
    
    for (int row = 0; row < cells; row++) {
      for (int col = 0; col < cells; col++) {
        Point point = points[row][col];
        
        if (point.distance(c) < closestPointDistance) {
          closestPoint = point;
          closestPointDistance = point.distance(c);
        }
      }
    }
    
    return closestPoint;
  }
  
  void select() {
    selected = true;
  }
  
  void deselect() {
    selected = false;
  }
}
