int circleCount = 2000;

float px[];
float amp[];
float phase[];
int alpha[];

void setup() {
  px = new float[circleCount];
  amp = new float[circleCount];
  phase = new float[circleCount];
  alpha = new int[circleCount];
  for (int i=0; i<circleCount; ++i) {
    px[i] = random(0, 1);
    amp[i] = random(0, 1);
    phase[i] = ((int) random(0, 6)) / 6.0 + ((int) random(-1, 0));
    alpha[i] = (int) (phase[i] * 256);
  }
  frame.setResizable(true);
}

void draw() {
  background(255);
  noStroke();
  for (int i=0; i<circleCount; ++i) {
    fill(0, alpha[i]);
    int cx = (int) (px[i] * width);
    int cy = (int) ((0.5 + 0.5 * amp[i] * sin(phase[i]*TWO_PI)) * height);
    ellipse(cx, cy, 10, 10);
    phase[i] += (0.01 % 1.0);
  }
}
