abstract class Grid {
  int lines;
  Point[][] points;
  Point[][] textureMappingPoints;
  boolean selected;
    
  color c;
  PImage image;
  
  public Grid(float x, float y, float w, float h, int n, color c) {
    points = new Point[n][n];
    lines = n;
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
    for (int row = 0; row < lines; row++) {
      for (int col = 0; col < lines; col++) {
        int nextRow = row + 1 < lines ? row + 1 : lines - 1;
        int nextCol = col + 1 < lines ? col + 1 : lines - 1;
        
        points[row][col].lineTo(points[nextRow][col]);
        points[row][col].lineTo(points[row][nextCol]);
      }
    }
    
    for (int row = 0; row < lines - 1; row++) {
      int nextRow = row + 1 < lines ? row + 1 : lines - 1;
      
      points[row][lines - 1].lineTo(points[nextRow][lines - 1]);
    }
    
    for (int col = 0; col < lines - 1; col++) {
      int nextCol = col + 1 < lines ? col + 1 : lines - 1;
      
      points[lines - 1][col].lineTo(points[lines - 1][nextCol]);
    }
  }
  
  void drawImage() {
    if (image == null || textureMappingPoints == null) {
      return;
    }
    
    textureMode(NORMAL);
    beginShape(QUADS);
    
    for (int row = 0; row < lines - 1; row++) {
      beginShape(QUAD_STRIP);
      texture(image);
      
      for (int col = 0; col < lines; col++) {
        Point a = points[row][col];
        Point aTexture = textureMappingPoints[row][col];
        
        Point b = points[row + 1][col];
        Point bTexture = textureMappingPoints[row + 1][col];
        
        vertex(a.x, a.y, aTexture.x, aTexture.y);
        vertex(b.x, b.y, bTexture.x, bTexture.y);
      }
      
      endShape();
    }
    
    endShape();
  }
  
  void moveByMouseDelta() {
    for (int row = 0; row < lines; row++) {
      for (int col = 0; col < lines; col++) {  
        points[row][col].translate(mouseX - pmouseX, mouseY - pmouseY);
      }
    }
  }
  
  void rotateByMouseDelta() {
    Point centroid = centroidOfPoints(points);
    
    float angle = new Vector(centroid, new Point(mouseX, mouseY)).angle(new Vector(centroid, new Point(pmouseX, pmouseY)));
    
    for (int row = 0; row < lines; row++) {
      for (int col = 0; col < lines; col++) {
        points[row][col].rotateAroundPoint(angle, centroid);
      }
    }
  }
  
  void scaleByMouseDelta() {
    Point centroid = centroidOfPoints(points);
    float centroidToMouseDistance = centroid.distance(new Point(mouseX, mouseY));
    float centroidToPastMouseDistance = centroid.distance(new Point(pmouseX, pmouseY));
    float scale = (centroidToPastMouseDistance - centroidToMouseDistance) / centroidToPastMouseDistance;
    
    for (int row = 0; row < lines; row++) {
      for (int col = 0; col < lines; col++) {
        points[row][col].scaleAroundPoint(scale, centroid);
      }
    }    
  }
  
  void setShape(Grid grid) {
    Point[] extremes = extremes();
    Point[] gridExtremes = grid.extremes();
    
    if (lines != grid.lines) {
      return;
    }
    
    for (int row = 0; row < lines; row++) {
      for (int col = 0; col < lines; col++) {
        Point point = grid.points[row][col];
        
        points[row][col] = new Point(point.x - gridExtremes[0].x + extremes[0].x, point.y - gridExtremes[0].y + extremes[0].y);
      }
    }    
  }
  
  Point[] extremes() {
    Point[] extremes = new Point[2];
    
    extremes[0] = new Point(Float.MAX_VALUE, Float.MAX_VALUE); // Min
    extremes[1] = new Point(Float.MIN_VALUE, Float.MIN_VALUE); // Max
    
    for (int row = 0; row < lines; row++) {
      for (int col = 0; col < lines; col++) {
        Point point = points[row][col];
        
        extremes[0].x = min(point.x, extremes[0].x);
        extremes[0].y = min(point.y, extremes[0].y);
        
        extremes[1].x = max(point.x, extremes[1].x);
        extremes[1].y = max(point.y, extremes[1].y);
      }
    }
    
    return extremes;
  }
  
  Point getPointClosestToPoint(Point c) {
    Point closestPoint = null;
    float closestPointDistance = Float.MAX_VALUE;
    
    for (int row = 0; row < lines; row++) {
      for (int col = 0; col < lines; col++) {
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
