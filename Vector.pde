
class Vector {
  float x, y;
  
  public Vector(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  public Vector(Point a, Point b) {
    this.x = b.x - a.x;
    this.y = b.y - a.y;
  }

  Vector vectorByAdding(Point p) {
    return new Vector(x + p.x, y + p.y);
  }
  
  Vector vectorBySubtracting(Point p) {
    return new Vector(x - p.x, y - p.y);
  }
  
  Vector vectorByAdding(Vector v) {
    return new Vector(x + v.x, y + v.y);
  }
  
  Vector vectorBySubtracting(Vector v) {
    return new Vector(x - v.x, y - v.y);
  }
  
  Vector vectorByMultiplying(float s) {
    return new Vector(x * s, y * s);
  }
  
  Vector rotated() {
    return new Vector(-this.y, this.x);
  }
  
  Vector vectorByNormalizing() {
    float n = sqrt(sq(x) + sq(y));
    
    if (n > 0.000001) {
      return new Vector(x / n, y / n);
    }
    
    return null;
  }
  
  float dot(Vector v) {
    return this.x * v.x + this.y * v.y;
  }
  
  float det(Vector v) {
    return this.rotated().dot(v);
  }
  
  float magnitude() {
    return new Point(x, y).distance(0, 0);
  }
  
  float angle(Vector v) {
    return atan2(det(v), dot(v));
  }
  
  String toString() {
    return String.format("[%f, %f]", x, y);
  }
}
