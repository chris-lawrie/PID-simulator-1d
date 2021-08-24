// Intialise gains to be zeros 
float kp = 0.0; 
float ki = 0.0; 
float kd = 0.0; 

// Initialise other variables used in code
float err = 0; 
float actual = 0;
float cum_err = 0; 
float err_last = 0; 
float delta_err = 0; 
PFont f;
color b = #3C03FF;
color r = #F55719;


// Array list of dots for the leader and follower 
ArrayList<Point> points_lead;  // controlled by mouse
ArrayList<Point> points_follow; // controlled by PID 


// Set up the sketch
void setup() {
  size(600,800); 
  background(0); 
  frameRate(60); 
  f = createFont("Arial",16,true);
  points_follow = new ArrayList<Point>(); 
  points_lead = new ArrayList<Point>(); 
}


// Begin drawing function
void draw() {
  // Colour the follow ball green if its close to the target
  color ball_col = #F55719; 
  if(abs(actual - mouseY) < 2 && mouseY > 5){
    ball_col = #7CDB86;
  }
  
  
// Don't allow negative gains 
  if(kp <= 0) kp = 0; 
  if(kd <= 0) kd = 0; 
  if(ki <= 0) ki = 0; 
  
  
// PID control for follow ball
  err = mouseY - actual;
  cum_err += err;
  delta_err = err - err_last;
  err_last = err;
  actual = (kp)*err + (ki)*cum_err + (kd)*delta_err; 
  
  println(mouseY);
  println(err);
  println("-----");
  
// Actually draw things now  
  background(0); 
  fill(75,75,255); 
  stroke(255);
  line(0,mouseY, width, mouseY); 
  noStroke(); 
  circle(width/2 + 150, mouseY, 50);
  
  
  fill(ball_col); 
  circle(width/2, actual, 50);
  points_follow.add(new Point(width/2, actual, r)); 
  points_lead.add(new Point(width/2, mouseY, b)); 
  
  
 // code to display two sets of tracer dots 
 
  
 for (int i = 0; i < points_lead.size()-1; i++){
    Point p = points_lead.get(i); 
    p.display(); 
    p.move();
    if(p.is_dead() == true) points_lead.remove(i); 
  }
  
     for (int i = 0; i < points_follow.size()-1; i++){
    Point p = points_follow.get(i); 
    p.display(); 
    p.move();
    if(p.is_dead() == true) points_follow.remove(i); 
  }

  
  // Print some text
  fill(255);
  textFont(f,16);  
  text("Lead Ball", width/2 + 100, 20);
  text("Follow Ball", width/2 -45, 20); 
  text("Kp = " + str(kp), 500, 700); 
  text("Ki =  " + str(ki), 500, 720); 
  text("Kd = " + str(kd), 500, 740); 
  text("Pess p/o, i/u, d/s to change gains", 200, height - 20); 

}


// Code to allow interaction with gians 
void keyPressed() {
  if(key == 'p') kp += 0.05;
  if(key == 'o') kp -= 0.05;
  if(key == 'i') ki += 0.05;
  if(key == 'u') ki -= 0.05;
  if(key == 'd') kd += 0.05;
  if(key == 's') kd -= 0.05;
}
  
