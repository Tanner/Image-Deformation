
Point centroidOfPoints(Point[][] points) {
  float x = 0;
  float y = 0;
  
  int size = 0;
  
  for (int row = 0; row < points.length; row++) {
    for (int col = 0; col < points[row].length; col++) {
      Point point = points[row][col];
      
      x += point.x;
      y += point.y;
      
      size++;
    }
  }
  
  return new Point(x / size, y / size);
}
