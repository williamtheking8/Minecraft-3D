import java.awt.Robot;

color black = #000000;
color white = #FFFFFF;
color green = #00f12b;
color blue = #4f00f1;

int gridSize;
PImage map;

Robot rbt;

float eyeX, eyeY, eyeZ; 
float focusX, focusY, focusZ;
float upX, upY, upZ;
float leftRightHeadAngle, upDownHeadAngle;

boolean wkey, akey,dkey,skey;

PImage Obsidian;
PImage Portal;
PImage Grass;


void setup() {
  textureMode(NORMAL);
 try{
 rbt = new Robot();
}
catch (Exception e) {
  e.printStackTrace();
}
size(displayWidth,displayHeight,P3D);

eyeX = width/2;
eyeY = height/2;
eyeZ = 0;
focusX = width/2;
focusY = height/2;
focusZ = eyeZ;
upX = 0;
upY = 1;
upZ = 0;

wkey = akey = skey = dkey = false;
upDownHeadAngle = radians(90);
leftRightHeadAngle = radians(270);


map = loadImage("Map.png");

Obsidian = loadImage("Obsidian.png");

Portal = loadImage("Portal.jpg");

Grass = loadImage("Grass_Block_Top.png");

gridSize = 400;

try{
  rbt = new Robot();
}
catch (Exception e) {
 e.printStackTrace(); 
}


}
void draw() {
  background(0);

   camera(eyeX, eyeY, eyeZ, focusX,focusY,focusZ,upX,upY,upZ);

  drawFloor(-7200,30000,height,gridSize);
  drawFloor(-7200,30000,0,gridSize);
  drawFocalPoint();
  controlCamera();
  
  
  
 // drawAxis();

  drawMap();
}
void TexturedCube(float x, float y, float z, PImage side, float size) {
  pushMatrix();
  translate(x, y, z);

  noStroke();
  scale(size);
  beginShape(QUADS);
  texture(side);

  //top  x  y  z  tx ty
  vertex(0, 0, 0, 0, 0);
  vertex(1, 0, 0, 1, 0);
  vertex(1, 0, 1, 1, 1);  
  vertex(0, 0, 1, 0, 1);

  
  
  //bottom
  vertex(0, 1, 0, 0, 0);
  vertex(1, 1, 0, 1, 0);
  vertex(1, 1, 1, 1, 1);  
  vertex(0, 1, 1, 0, 1);


  //front
  vertex(0, 0, 1, 0, 0);
  vertex(1, 0, 1, 1, 0);
  vertex(1, 1, 1, 1, 1);  
  vertex(0, 1, 1, 0, 1);

  //back
  vertex(0, 0, 0, 0, 0);
  vertex(1, 0, 0, 1, 0);
  vertex(1, 1, 0, 1, 1);  
  vertex(0, 1, 0, 0, 1);

  //right
  vertex(1, 0, 1, 0, 0);
  vertex(1, 0, 0, 1, 0);
  vertex(1, 1, 0, 1, 1);  
  vertex(1, 1, 1, 0, 1);

  //left
  vertex(0, 0, 1, 0, 0);
  vertex(0, 0, 0, 1, 0);
  vertex(0, 1, 0, 1, 1);  
  vertex(0, 1, 1, 0, 1);

  endShape();





  popMatrix();
}







void drawFocalPoint() {
  pushMatrix();
  translate(focusX,focusY,focusZ);
  sphere(5);
  popMatrix();

}
void keyPressed() {
  if (key == 'w'|| key == 'W') {
    wkey = true;
  }
  if (key == 's'|| key == 'S') {
    skey = true;
  }
  if (key == 'a'|| key == 'A') {
    akey = true;
  }
  if (key == 'd'|| key == 'D') {
    dkey = true;
  }
}
void keyReleased() {
  if (key == 'w'|| key == 'W') {
    wkey = false;
  }
  if (key == 's'|| key == 'S') {
    skey = false;
  }
  if (key == 'a'|| key == 'A') {
    akey = false;
  }
  if (key == 'd'|| key == 'D') {
    dkey = false;
  }
}

void drawMap() {
 for (int x = 0; x < map.width; x++) {
   for (int y = 0; y < map.height; y++) {
     color c = map.get(x,y);
     if (c == blue) {
      TexturedCube(x*gridSize-7200,height-gridSize, y*gridSize-7200,Portal,gridSize);
      TexturedCube(x*gridSize-7200,height-gridSize*2, y*gridSize-7200,Portal,gridSize);
      
     TexturedCube(x*gridSize-7200,height-gridSize*3, y*gridSize-7200,Portal,gridSize);

 
   } if (c == green) {
   TexturedCube(x*gridSize-7200,height-gridSize, y*gridSize-7200,Obsidian,gridSize);
      TexturedCube(x*gridSize-7200,height-gridSize*2, y*gridSize-7200,Obsidian,gridSize);
     TexturedCube(x*gridSize-7200,height-gridSize*3, y*gridSize-7200,Obsidian,gridSize);

 }
   }
}
}
void drawFloor(int start, int end, int level, int gap){
  stroke(255);
  strokeWeight(1);
  int x = start;
  int z = start;
  while (z < end) {
    TexturedCube(x,level,z,Grass, gap);
    x = x + gap;
    if(x >= end){
      x = start;
    z = z + gap;
    }
    
  }
  
}
void controlCamera() {
 
  if(wkey) {
    eyeX += cos(leftRightHeadAngle)*100;
    eyeZ += sin(leftRightHeadAngle)*100;
  }
  if(skey) {
   eyeX -= cos(leftRightHeadAngle)*100;
   eyeZ -= sin(leftRightHeadAngle)*100; 
  }
  if(akey){
  eyeZ -= sin(leftRightHeadAngle + PI/2)*100; 
   eyeX -= cos(leftRightHeadAngle + PI/2)*100;
  }
  if(dkey) {
   eyeZ += sin(leftRightHeadAngle + PI/2)*100; 
   eyeX += cos(leftRightHeadAngle + PI/2)*100; 
  }
  
  leftRightHeadAngle = leftRightHeadAngle + (mouseX - pmouseX)*0.01;
  upDownHeadAngle = upDownHeadAngle + (mouseY - pmouseY)*0.01;
  if(upDownHeadAngle > PI/2.5) upDownHeadAngle = PI/2.5;
  if(upDownHeadAngle < -PI/2.5) upDownHeadAngle = -PI/2.5;
  
  focusX = eyeX + cos(leftRightHeadAngle)*300;
  focusY = eyeY + tan(upDownHeadAngle)*300;
  focusZ = eyeZ + sin(leftRightHeadAngle)*300;
  
  
  if(mouseX > width-2) rbt.mouseMove(2,mouseY);
  else if (mouseX < 2) rbt.mouseMove(width-2,mouseY);
}
