class Wall extends MapObject {
  Wall(Coordinate pos) {
    super(pos);
  }
  void display(int x, int y, int sizeX, int sizeY) {
   fill(255,0,0);
   rect(x,y,sizeX, sizeY);
  }
}
