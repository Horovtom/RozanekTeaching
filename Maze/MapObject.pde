abstract class MapObject {
  Coordinate position;

  MapObject(Coordinate pos) {
    this.position = pos.copy();
  }

  abstract void display(int x, int y, int sizeX, int sizeY);

  void update() {
  }
}
