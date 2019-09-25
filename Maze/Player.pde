class Player extends MapObject {
  Player(Coordinate pos) {
    super(pos);
  }
  
  void display(int x, int y, int sizeX, int sizeY) {
    fill(0);
    println("Displaying player at: " + x + " " + y);
    rect(x, y, sizeX, sizeY);
  }
}
