class MapHolder {
 MapObject[][] map;
 final int MAP_WIDTH, MAP_HEIGHT;
 
 MapHolder(int sizeX, int sizeY){
   MAP_WIDTH = sizeX;
   MAP_HEIGHT = sizeY;
  map = new MapObject[sizeX][sizeY]; 
 }
 
 MapObject get(Coordinate pos) {
   if (!isValid(pos)) {
    println("MapHolder::get: " + pos + " is not valid position on the map!");
    return null;
   }
   
   return map[pos.x][pos.y];
 }
 
 void set(Coordinate pos, MapObject object) {
  if (!isValid(pos)){
   println("MapHolder::set: " + pos + " is not valid position on the map!");
   return;
  }
  
  map[pos.x][pos.y] = object;
 }
 
 boolean isValid(Coordinate pos) {
   return pos.x >= 0 && pos.x < MAP_WIDTH && pos.y >= 0 && pos.y < MAP_HEIGHT; 
 } 
}
