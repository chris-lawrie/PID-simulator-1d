// Simple class to create Array lists of points to trace the motion from the balls. 

class Point{
float x; 
float y;
float d;
float stepx = -2;
float lifespan = 800; 
color col; 

Point(float _x, float _y, color a) {
  x = _x;
  y = _y; 
  d = 3;
  col = a; 
}

void move() {
x = x + stepx;
lifespan -= 5; 
}


void display() {
 noStroke();
 fill(col);
 ellipse(x,y,d,d); 
}

boolean is_dead() {
  if(lifespan <= 0) return true; 
  else return false; 
}

}
