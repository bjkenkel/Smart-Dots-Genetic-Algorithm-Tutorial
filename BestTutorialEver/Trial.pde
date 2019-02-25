class Trial{
  Population pop;
  PVector goal;
  Obstacle[] walls = {new Obstacle(0, 600, 200, 10), new Obstacle(200, 600, 400, 10), new Obstacle(0, 600, 600, 10)};
  
  Trial(int size, PVector goal_in){
    pop = new Population(size);
    goal = goal_in;
    println("generation: 1");
  }
  
  void show(){
    background(255);

    //draw goal
    fill(255, 0, 0);
    ellipse(goal.x, goal.y, 10, 10);
    
    for(int i = 0; i < walls.length; i++){
      walls[i].show();
    }
    
    
    if (pop.allDotsDead()) {
      //genetic algorithm
      pop.calculateFitness();
      pop.naturalSelection();
      pop.mutateDemBabies();
    } else {
      //if any of the dots are still alive then update and then show them
  
      pop.update(walls);
      pop.show();
    }
  }
}
