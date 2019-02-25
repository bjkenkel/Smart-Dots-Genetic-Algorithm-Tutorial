class Dot {
  PVector pos;
  PVector vel;
  PVector acc;
  Brain brain;

  boolean dead = false;
  boolean reachedGoal = false;
  boolean isBest = false;//true if this dot is the best dot from the previous generation
  boolean diedFromObstacle = false;

  float fitness = 0;

  Dot() {
    brain = new Brain(2000);//new brain with 1000 instructions

    //start the dots at the bottom of the window with a no velocity or acceleration
    pos = new PVector(100, 700);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
  }


  //-----------------------------------------------------------------------------------------------------------------
  //draws the dot on the screen
  void show() {
    //if this dot is the best dot from the previous generation then draw it as a big green dot
    if (isBest) {
      fill(0, 255, 0);
      ellipse(pos.x, pos.y, 8, 8);
    } else {//all other dots are just smaller black dots
      fill(0);
      ellipse(pos.x, pos.y, 4, 4);
    }
  }

  //-----------------------------------------------------------------------------------------------------------------------
  //moves the dot according to the brains directions
  void move() {

    if (brain.directions.length > brain.step) {//if there are still directions left then set the acceleration as the next PVector in the direcitons array
      acc = brain.directions[brain.step];
      brain.step++;
    } else {//if at the end of the directions array then the dot is dead
      dead = true;
    }

    //apply the acceleration and move the dot
    vel.add(acc);
    vel.limit(5);//not too fast
    pos.add(vel);
  }

  //-------------------------------------------------------------------------------------------------------------------
  //calls the move function and check for collisions and stuff
  void update(Obstacle[] walls) {
    if (!dead && !reachedGoal) {
      move();
      if (pos.x< 2|| pos.y<2 || pos.x>width-2 || pos.y>height -2) {//if near the edges of the window then kill it 
        dead = true;
      } else if (dist(pos.x, pos.y, goal.x, goal.y) < 5) {//if reached goal
        reachedGoal = true;
      } else { 
        for(int i = 0; i < walls.length; i++){
          if(walls[i].contains(pos.x, pos.y)){
            dead = true;
            diedFromObstacle = true;
            break;
          }
        }
      }
    }
  }


  //--------------------------------------------------------------------------------------------------------------------------------------
  //calculates the fitness
  void calculateFitness() {
    if (reachedGoal) {//if the dot reached the goal then the fitness is based on the amount of steps it took to get there
      fitness = 1000000 + 1000000.0/(float)(brain.step * brain.step);
    } else {//if the dot didn't reach the goal then the fitness is based on how close it is to the goal
      if(pos.y < 200){
        float distanceToGoal = dist(pos.x, pos.y, goal.x, goal.y);
        fitness = 1000 + 1.0/(distanceToGoal * distanceToGoal);
      //  if(pos.x < 200) fitness = 1;
      //  else if(pos.x < 300) fitness = 0.95;
      //  else if(pos.x < 400) fitness = 0.90;
      //  else if(pos.x < 500) fitness = 0.85;
      //  else if(pos.x < 600) fitness = 0.80;
      //  else fitness = 0.75;
      }
      else if(pos.y < 400){
        float distanceToGoal = dist(pos.x, pos.y, 700, 100);
        fitness = 100 + 1.0/(distanceToGoal * distanceToGoal);
      //  if(pos.x > 600) fitness = 0.70;
      //  else if(pos.x > 466) fitness = 0.65;
      //  else if(pos.x > 333) fitness = 0.60;
      //  else if(pos.x > 200) fitness = 0.55;
      //  else fitness = 0.50;
      }
      else if(pos.y < 600){
        float distanceToGoal = dist(pos.x, pos.y, 100, 300);
        fitness = 10 + 1.0/(distanceToGoal * distanceToGoal);
      //  if(pos.x < 200) fitness = 0.45;
      //  else if(pos.x < 333) fitness = 0.40;
      //  else if(pos.x < 466) fitness = 0.35;
      //  else if(pos.x < 600) fitness = 0.30;
      //  else fitness = 0.25;
      }
      else {
        float distanceToGoal = dist(pos.x, pos.y, 700, 500);
        fitness = 1 + 1.0/(distanceToGoal * distanceToGoal);
      //  if(pos.x > 600) fitness = 0.20;
      //  else if(pos.x > 466) fitness = 0.15;
      //  else if(pos.x > 333) fitness = 0.10;
      //  else if(pos.x > 200) fitness = 0.05;
      //  else fitness = 0.0;
      }
      //fitness += 0.01/(float)(brain.step);
      //fitness = fitness * fitness * fitness;
      
      //float distanceToGoal = dist(pos.x, pos.y, goal.x, goal.y);
      //fitness = 1.0/(distanceToGoal * distanceToGoal);
      //if(pos.y < 600){
      //  fitness += 0.00001;
      //}
      //if(pos.y < 400){
      //  fitness += 0.00001;
      //}
      //if(pos.y < 200){
      //  fitness += 0.00001;
      //}
    }
  }

  //---------------------------------------------------------------------------------------------------------------------------------------
  //clone it 
  Dot gimmeBaby() {
    Dot baby = new Dot();
    baby.brain = brain.clone();//babies have the same brain as their parents
    return baby;
  }
}
