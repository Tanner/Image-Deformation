
Point centroidOfPoints(ArrayList<Point> points) {
  float x = 0;
  float y = 0;
  
  for (Point p : points) {      
    x += p.x;
    y += p.y;
  }
  
  return new Point(x / points.size(), y / points.size());
}
