
Point bezierPoint(Point a, Point b, Point c, float t) {
  Point p = a.linearInterpolationToPoint(b, t);
  Point q = b.linearInterpolationToPoint(c, t);
  
  return p.linearInterpolationToPoint(q, t);
}

Point bezierPoint(Point a, Point b, Point c, Point d, float t) {
  Point p = bezierPoint(a, b, c, t);
  Point q = bezierPoint(b, c, d, t);
  
  return p.linearInterpolationToPoint(q, t);
}

Point bezierPoint(Point a, Point b, Point c, Point d, Point e, float t) {
  Point p = bezierPoint(a, b, c, t);
  Point q = bezierPoint(c, d, e, t);
  
  return p.linearInterpolationToPoint(q, t);
}

class Point {
  float x, y;
  
  public Point(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  void lineTo(Point b) {
    line(this.x, this.y, b.x, b.y);
  }
  
  void display() {
    ellipse(x,
            y,
            g.strokeWeight * 2,
            g.strokeWeight * 2);
  }
  
  void setX(float x) {
    this.x = x;
  }
  
  void setY(float y) {
    this.y = y;
  }
  
  void setCoords(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  float angle(Point p) {
    if (p.x < this.x) {
      return PI + atan((p.y - this.y) / (p.x - this.x));
    }
    
    return atan((p.y - this.y) / (p.x - this.x));
  }
  
  float angle(float x, float y) {
    return angle(new Point(x, y));
  }
  
  float distance(Point p) {
    return sqrt(sq(p.x - this.x) + sq(p.y - this.y));
  }
  
  float distance(float x, float y) {
    return abs(distance(new Point(x, y)));
  }
  
  Point average(Point p) {
    return new Point((this.x + p.x) / 2, (this.y + p.y) / 2);
  }
  
  Point pointByAddingVector(Vector v) {
    return new Point(this.x + v.x, this.y + v.y);
  }
  
  Point pointScaledByVector(Vector v) {
    return new Point(this.x * v.x, this.y * v.y);
  }
  
  Point pointByAddingPoint(Point p) {
    return new Point(this.x + p.x, this.y + p.y);
  }
  
  float slope(Point p) {
    return (p.y - this.y) / (p.x - this.x);
  }
  
  void translate(float x, float y) {
    this.x += x;
    this.y += y;
  }
  
  void rotateAroundPoint(float a, Point p) {
    float dx = x - p.x;
    float dy = y - p.y;
    float c = cos(a);
    float s = sin(a);
    
    this.x = p.x + c * dx + s * dy;
    this.y = p.y - s * dx + c * dy;
  }
  
  void scaleAroundPoint(float s, Point p) {
    this.x += s * (p.x - x);
    this.y += s * (p.y - y);
  }
  
  Point linearInterpolationToPoint(Point end, float time) {
    return new Point(x + time * (end.x - x), y + time * (end.y - y));
  }
  
  String toString() {
    return String.format("(%f, %f)", x, y);
  }
}
