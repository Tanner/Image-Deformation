class Grid {
  int cells;
  ArrayList<Point> points;
  boolean selected;
  
  color c;
  PImage image;
  
  public Grid(float x, float y, float w, float h, int n, color c) {
    points = new ArrayList<Point>();
    cells = n;
    this.c = c;
    
    float horizontalSpacing = w / (n - 1);
    float verticalSpacing = h / (n - 1);
        
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {        
        float pointX = horizontalSpacing * j + x;
        float pointY = verticalSpacing * i + y;
        
        points.add(new Point(pointX, pointY));
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
  
  void moveByMouseDelta() {
    for (Point p : points) {
      p.translate(mouseX - pmouseX, mouseY - pmouseY);
    }
  }
  
  void rotateByMouseDelta() {
    Point centroid = centroidOfPoints(points);
    
    float angle = new Vector(centroid, new Point(mouseX, mouseY)).angle(new Vector(centroid, new Point(pmouseX, pmouseY)));
    
    for (Point p : points) {
      p.rotateAroundPoint(angle, centroid);
    }
  }
  
  void scaleByMouseDelta() {
    Point centroid = centroidOfPoints(points);
    float centroidToMouseDistance = centroid.distance(new Point(mouseX, mouseY));
    float centroidToPastMouseDistance = centroid.distance(new Point(pmouseX, pmouseY));
    float scale = (centroidToPastMouseDistance - centroidToMouseDistance) / centroidToPastMouseDistance;

    for (Point p : points) {
      p.scaleAroundPoint(scale, centroid);
    }
  }
  
  Point getPointClosestToPoint(Point c) {
    Point closestPoint = null;
    float closestPointDistance = Float.MAX_VALUE;
    
    for (Point p : points) {
      if (p.distance(c) < closestPointDistance) {
        closestPoint = p;
        closestPointDistance = p.distance(c);
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
