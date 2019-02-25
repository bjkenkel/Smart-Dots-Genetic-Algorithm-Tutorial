Trial test;
PVector goal  = new PVector(100, 100);


void setup() {
  size(800, 800); //size of the window
  frameRate(100);//increase this to make the dots go faster
  test = new Trial(5000, goal);//create a new population with 1000 members
}


void draw() { 
    test.show();
}
