import gifAnimation.*;

TreeSegment rootSegment;

float rootLength = 12.0;
float rootAngle = 0.3;
float angleDecay = 0.95;
float rw = 0.0;
int depth = 11;

int actRandomSeed = 0;

int frames = 0;
int gifFrames = 100;
GifMaker gifExport;


void branchSegment(TreeSegment parent, float len, float angle, float aD, int depth) {
  if (depth > 0) {
    TreeSegment left = new TreeSegment(parent, len, angle);
    TreeSegment right = new TreeSegment(parent, len, -angle);
    angle *= aD;
    branchSegment(left, len, angle, aD, depth-1);
    branchSegment(right, len, angle, aD, depth-1);
  }
}

void setup() {
  size(400, 300);
  rootSegment = new TreeSegment(null, rootLength, 0);
  branchSegment(rootSegment, rootLength, rootAngle, angleDecay, depth);
  
  gifExport = new GifMaker(this, "wiggly.gif");
  gifExport.setRepeat(0);
}

void draw() {
  randomSeed(actRandomSeed);
  background(180);
  pushMatrix();
  translate(width/2.0, height/2.0);
  rootSegment.display(0, 0, 0, abs(rw - 1.0));
  popMatrix();
  rw = (rw + 0.01) % 2.0;
  
  gifExport.addFrame();
  gifExport.setDelay(1000/20);  //12fps in ms
  if (frames > gifFrames) {
    gifExport.finish();  
  } else {
    frames++;
  }
}
