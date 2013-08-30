/**
 * This demo shows a simple 2D car steering algorithm and alignment of
 * the car on the 3D terrain surface. The demo also features a third
 * person camera, following the car and re-orienting itself towards the
 * current direction of movement. The camera ensures it's always positioned
 * above ground level too...
 * 
 * Copyright (c) 2010 Karsten Schmidt
 * 
 */
 
import toxi.geom.*;
import toxi.geom.mesh.*;
import toxi.math.*;
import toxi.processing.*;

import processing.opengl.*;

float NOISE_SCALE = 0.08f;
int DIM=40;

Terrain terrain;
ToxiclibsSupport gfx;
Mesh3D mesh;
Car car;

Vec3D camOffset = new Vec3D(0, 100, 300);
Vec3D eyePos = new Vec3D(0, 1000, 0);

void setup() {
  size(displayWidth,displayHeight,P3D);
  orientation(PORTRAIT);
  // create terrain & generate elevation data
  terrain = new Terrain(DIM,DIM, 50);
  float[] el = new float[DIM*DIM];
  noiseSeed(23);
  for (int z = 0, i = 0; z < DIM; z++) {
    for (int x = 0; x < DIM; x++) {
      el[i++] = noise(x * NOISE_SCALE, z * NOISE_SCALE) * 400;
    }
  }
  terrain.setElevation(el);
  // create mesh
  mesh = terrain.toMesh();
  // create car
  car = new Car(0, 0);
  // attach drawing utils
  gfx = new ToxiclibsSupport(this);
}

void draw() {
/*  if (keyPressed) {
    if (keyCode == UP) {
      car.accelerate(1);
    }
    if (keyCode == DOWN) {
      car.accelerate(-1);
    }
    if (keyCode == LEFT) {
      car.steer(0.1f);
    }
    if (keyCode == RIGHT) {
      car.steer(-0.1f);
    }
  }
*/
  // update steering & position
  car.update();
  // adjust camera offset & rotate behind car based on current steering angle
  Vec3D camPos = car.pos.add(camOffset.getRotatedY(car.currTheta + HALF_PI));
  camPos.constrain(mesh.getBoundingBox());
  float y = terrain.getHeightAtPoint(camPos.x, camPos.z);
  if (!Float.isNaN(y)) {
    camPos.y = max(camPos.y, y + 100);
  }
  eyePos.interpolateToSelf(camPos, 0.05f);     
  background(0xffaaeeff);
  camera(eyePos.x, eyePos.y, eyePos.z, car.pos.x, car.pos.y, car.pos.z, 0, -1, 0);
  // setup lights
  directionalLight(192, 160, 128, 0, -1000, -0.5f);
  directionalLight(255, 64, 0, 0.5f, -0.1f, 0.5f);
  fill(255);
  noStroke();
  // draw mesh & car
  gfx.mesh(mesh, false);
  car.draw();
}

void mousePressed()
{
  if(mouseY<height/2)
  {
    car.accelerate(1);
    if(mouseX<width/2)
    {
     car.steer(0.1f); 
    }
    if(mouseX>width/2)
    {
      car.steer(-0.1f);
    }
  }
  if(mouseY>height/2)
  {
    car.accelerate(-1);
    if(mouseX<width/2)
    {
     car.steer(0.1f); 
    }
    if(mouseX>width/2)
    {
      car.steer(-0.1f);
    }
  }
}

