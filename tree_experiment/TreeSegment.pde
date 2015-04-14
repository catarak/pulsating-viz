class TreeSegment {
  float len;
  float angle;
  
  TreeSegment parent;
  ArrayList<TreeSegment> children;
  
  TreeSegment(TreeSegment parent_, float len_, float angle_) {
    parent = parent_;
    if (parent != null) {
      parent.children.add(this);
    }
    children = new ArrayList<TreeSegment>();
    len = len_;
    angle = angle_;
  }
  
  void display(float px, float py, float angleSum, float rw) {
    noFill();
    stroke(0);
    strokeWeight(2);
    angleSum += angle;
    float nx = px - len * sin(angleSum);
    float ny = py - len * cos(angleSum);
    
    float rx = random(-width/2.0, width/2.0);
    float ry = random(-height/2.0, height/2.0);
    
    float sx = px * (1.0 - rw) + rx * rw;
    float sy = py * (1.0 - rw) + ry * rw;
    float fx = nx * (1.0 - rw) + rx * rw;
    float fy = ny * (1.0 - rw) + ry * rw;
    
    line(sx, sy, fx, fy);
    for (TreeSegment t : children) {
      t.display(nx, ny, angleSum, rw);
    }
  }
}
