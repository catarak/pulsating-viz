// P_2_1_1_01.pde
// 
// Generative Gestaltung, ISBN: 978-3-87439-759-9
// First Edition, Hermann Schmidt, Mainz, 2009
// Hartmut Bohnacker, Benedikt Gross, Julia Laub, Claudius Lazzeroni
// Copyright 2009 Hartmut Bohnacker, Benedikt Gross, Julia Laub, Claudius Lazzeroni
//
// http://www.generative-gestaltung.de
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

/**
 * changing strokeweight and strokecaps on diagonals in a grid
 * 	 
 * MOUSE
 * position x          : left diagonal strokeweight
 * position y          : right diagonal strokeweight
 * left click          : new random layout
 * 
 * KEYS
 * 1                   : round strokecap
 * 2                   : square strokecap
 * 3                   : project strokecap
 * s                   : save png
 * p                   : save pdf
 */

import processing.pdf.*;
import java.util.Calendar;
import gifAnimation.*;

boolean savePDF = false;

int tileCount = 20;
int actRandomSeed = 0;
int tileToggles[][];

int actStrokeCap = ROUND;

float thetaX = 0.0;
float thetaY = PI;
float thetaIncr = 0.1;
int frames = 0;
int gifFrames = 100;

GifMaker gifExport;

void setup() {
  size(600, 600);
  frameRate(20);
  tileToggles = new int[tileCount][tileCount];
  reseedExcluding(-1);
  
  gifExport = new GifMaker(this, "wiggly.gif");
  gifExport.setRepeat(0);
  //gifExport.setTransparent(0,0,0);
//  gifExport.setTransparent(255); // make white the transparent color -- match browser bg color
}

void reseedExcluding(int excluded) {
  randomSeed(actRandomSeed);
  for (int j=0; j<tileCount; ++j) {
    for (int i=0; i<tileCount; ++i) {
      if (tileToggles[i][j] != excluded) {
        tileToggles[i][j] = (int) random(0,4);
        if (tileToggles[i][j] == excluded)
          tileToggles[i][j] = 2;
      }
    }
  }
}

void draw() {
  if (savePDF) beginRecord(PDF, timestamp()+".pdf");

  background(255);
  smooth();
  noFill();
  strokeCap(actStrokeCap);
  
  thetaX += thetaIncr;
  thetaY += thetaIncr;
  if (thetaX > TWO_PI)
    thetaX = 0;
  if (thetaY > TWO_PI)
    thetaY = 0;

  for (int gridY=0; gridY<tileCount; gridY++) {
    for (int gridX=0; gridX<tileCount; gridX++) {

      int posX = width/tileCount*gridX;
      int posY = height/tileCount*gridY;

      int toggle = tileToggles[gridX][gridY];

      if (toggle == 0) {
        float weightX = (0.5*sin(thetaX - PI/2.0)+ 0.5)* 20;
        if (weightX > 0.05) {
          strokeWeight(weightX);
          line(posX, posY, posX+width/tileCount, posY+height/tileCount);
        } else {
          println("reseed");
          reseedExcluding(1);
        }
      }
      if (toggle == 1) {
        float weightY = (0.5*sin(thetaY - PI/2.0)+ 0.5)* 20;
        if (weightY > 0.05) {
          strokeWeight(weightY);
          line(posX, posY+width/tileCount, posX+height/tileCount, posY);
        } else {
          reseedExcluding(0);
        }
      }
    }
  }
  
  gifExport.addFrame();
  gifExport.setDelay(1000/20);  //12fps in ms

  if (savePDF) {
    savePDF = false;
    endRecord();
  }
  
  if (frames > gifFrames) {
    gifExport.finish();  
  } else {
    frames++;
  }
}


void mousePressed() {
  actRandomSeed = (int) random(100000);
  reseedExcluding(-1);
}

void keyReleased(){
  if (key == 's' || key == 'S') saveFrame(timestamp()+"_##.png");
  if (key == 'p' || key == 'P') savePDF = true;

  if (key == '1'){
    actStrokeCap = ROUND;
  }
  if (key == '2'){
    actStrokeCap = SQUARE;
  }
  if (key == '3'){
    actStrokeCap = PROJECT;
  }
}



// timestamp
String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}








