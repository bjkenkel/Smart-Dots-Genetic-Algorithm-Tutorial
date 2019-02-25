class Obstacle{
  int x;
  int y;
  int height;
  int width;
  
  Obstacle(int i_x, int i_width, int i_y, int i_height){
    x = i_x;
    y = i_y;
    height = i_height;
    width = i_width;
  }
  
  void show(){
    fill(0, 0, 255);
    rect(x, y, width, height);
  }
  
  boolean contains(float i_x, float i_y){
    if(i_x > x && i_x < (x + width) && i_y > y && i_y < (y + height)){
      return true;
    }
    return false;
  }
}
