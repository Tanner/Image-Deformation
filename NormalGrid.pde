class NormalGrid extends Grid {
  BezierGrid bezierGrid;

  public NormalGrid(float x, float y, float w, float h, int n, color c) {
    super(x, y, w, h, n, c);
    
    bezierGrid = new BezierGrid(this, #00FFFF);
  }
  
  void drawImage(Grid baseGrid, PImage image, boolean drawWithBezierGrid) {
    if (drawWithBezierGrid) {
      this.bezierGrid.drawImage(baseGrid, image);
    } else {
      drawImage(baseGrid, image);
    }
  }
  
  void moveByMouseDelta() {
    super.moveByMouseDelta();
    
    bezierGrid.updatePoints();
  }
  
  void rotateByMouseDelta() {
    super.rotateByMouseDelta();
    
    bezierGrid.updatePoints();
  }
  
  void scaleByMouseDelta() {
    super.scaleByMouseDelta();
    
    bezierGrid.updatePoints();
  }
  
  void setShape(Grid grid) {
    super.setShape(grid);
    
    bezierGrid.updatePoints();
  }
  
  void setSamplingRate(int r) {
    bezierGrid.setSamplingRate(r);
  }
  
  int getSamplingRate() {
    return bezierGrid.samplingRate;
  }
}
