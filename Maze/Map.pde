class Map {
  final int MAP_WIDTH, MAP_HEIGHT;
  final int CELL_SIZE;
  Coordinate playerPosition;
  final MapHolder map;

  Map(int mapWidth, int mapHeight, int cellSize) {
    MAP_WIDTH = mapWidth;
    MAP_HEIGHT = mapHeight;
    CELL_SIZE = cellSize;
    map = new MapHolder(MAP_WIDTH, MAP_HEIGHT);
  }

  boolean playerPlaced() {
    return playerPosition != null;
  }

  void placePlayer(Coordinate pos) {
    if (!map.isValid(pos)) {
      println("placePlayer: Player is not in map!");
      return;
    }
    if (playerPlaced()) {
      println("placePlayer: Player is already on the map!");
      return;
    }

    playerPosition = pos.copy();
    map.set(pos, new Player(playerPosition));
  }

  void placeWall(Coordinate pos) {
    if (!isInMap(pos)) {
      println("placeWall: Wall is not in map!");
      return;
    }
    if (map.get(pos) != null) {
      println("There is already some object on coordinates: "+pos.toString());
      return;
    }

    map.set(pos, new Wall(pos));
  }

  boolean isInMap(Coordinate pos) {
    return map.isValid(pos);
  }

  /**
   * @return Start of view port that is to be drawn on the display
   */
  Coordinate getStartOfViewPort() {
    // This works for odd values, because it floors the value
    int x = min(max((int) playerPosition.x - (VIEW_SIZE / 2), 0), MAP_WIDTH - VIEW_SIZE);
    int y = min(max((int) playerPosition.y - (VIEW_SIZE / 2), 0), MAP_HEIGHT - VIEW_SIZE);
    return new Coordinate(x, y);
  }

  boolean isFreeToMoveOn(Coordinate pos) {
    if (!isInMap(pos)) return false;
    if (map.get(pos) != null) return false;
    return true;
  }

  void move(int shiftX, int shiftY) {
    int moveToX = (int) playerPosition.x +shiftX;
    int moveToY = (int) playerPosition.y + shiftY;
    Coordinate where = new Coordinate(moveToX, moveToY);
    if (!isFreeToMoveOn(where)) {
      println("move: Cannot move to position: " + moveToX+ " " + moveToY);
      return;
    }

    map.set(where, map.get(playerPosition));
    map.set(playerPosition, null);

    playerPosition = where;
  }

  /**
   * @param x Coordinate of the top-left corner of the map
   * @param y Coordinate of the top-left corner of the map
   */
  void display(int x, int y) {
    Coordinate viewPortStart = getStartOfViewPort();

    for (int i = 0; i < VIEW_SIZE; i++) {
      for (int j = 0; j < VIEW_SIZE; j++) {
        stroke(1);
        strokeWeight(1);
        noFill();
        rect(x + i * CELL_SIZE, y + j * CELL_SIZE, CELL_SIZE, CELL_SIZE);
        MapObject currObj = map.get(Coordinate.add(viewPortStart, new Coordinate(i, j)));
        if (currObj != null)
          currObj.display(x + (i * CELL_SIZE), y + (j * CELL_SIZE), CELL_SIZE, CELL_SIZE);
      }
    }
  }
}
