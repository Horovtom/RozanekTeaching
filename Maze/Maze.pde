final int VIEW_SIZE = 9;
Map map;
int cellSize;

void setup() {
  size(640, 640); 
  cellSize = width / VIEW_SIZE;
  String error = loadMap("map.txt");
  if (error != null) {
    println("Map file loading failed: " + error);
    noLoop();
    exit();
  }
}

void draw() {
  background(255);
  if (map != null)
    map.display(0,0);
}


String loadMap(String path) {
  String[] lines = loadStrings(path);
  if (lines == null) 
    return "Map file not found!";
  if (lines.length < 2+VIEW_SIZE) 
    return "Map file has too low number of lines!";

  int mapWidth = Integer.parseInt(lines[0]);
  int mapHeight = Integer.parseInt(lines[1]);

  map = new Map(mapWidth, mapHeight, cellSize);

  for (int y = 0; y < mapHeight; y++) {
    // Skip the first two lines, there is information about map size there
    String currLine = lines[y+2];
    for (int x = 0; x < mapWidth; x++) {
      if (currLine.charAt(x) == 'x') {
        if (map.playerPlaced()) 
          return "Map file contains multiple players!";
        map.placePlayer(new Coordinate(x, y));
      } else if (currLine.charAt(x) == '#') {
        map.placeWall(new Coordinate(x,y));
      } else if (currLine.charAt(x) == '.') {
        // Pass
      } else 
       return "Map file contained invalid character: " + currLine.charAt(x); 
    }
  }
  
  return null;
}

void keyPressed() {
 if (keyCode == UP) map.move(0,-1);
 if (keyCode == LEFT) map.move(-1,0);
 if (keyCode == DOWN) map.move(0,1);
 if (keyCode == RIGHT) map.move(1, 0);
}
