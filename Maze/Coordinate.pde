static class Coordinate {
  int x, y;
  Coordinate() {
  }
  Coordinate(int x, int y) {
    this.x = x;
    this.y = y;
  }

  Coordinate copy() {
   return new Coordinate(x, y); 
  }
 
  static Coordinate add(Coordinate a, Coordinate b) {
    return new Coordinate(a.x + b.x, a.y + b.y);
  }
}
