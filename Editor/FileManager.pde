class FileManager
{
  void saveLevel()
  { 
    JSONObject level = new JSONObject();
    JSONArray wallsJS = new JSONArray();
    JSONObject wall;
    JSONArray vertices;
    JSONObject vertex;
    
    for( int i = 0; i < walls.size()-1; i++ )
    {
      wall = new JSONObject();
      vertices = new JSONArray();
      vertices.setJSONObject(0, new JSONObject().setInt("id", i+1 ));
      // -------- KOLOR --------
      JSONObject wallColor = new JSONObject();
      wallColor.setInt( "r", 10 );
      wallColor.setInt( "g", 20 );
      wallColor.setInt( "b", 30 );
      vertices.setJSONObject(1,wallColor);
      // ------------------------
      for( int j = 0; j < walls.get( i ).vertices.size(); j++ )
      {
        vertex = new JSONObject();
        vertex.setFloat( "x", (walls.get(i).vertices.get( j ).x-50)/8 );
        vertex.setFloat( "y", (walls.get(i).vertices.get( j ).y-50)/8 );
        vertices.setJSONObject(j+2,vertex);
      }
      wall.setJSONArray("wall", vertices);
      wallsJS.setJSONObject(i, wall);
    }
   
    level.setJSONArray("walls", wallsJS);
    saveJSONObject( level, "level.json" );
  }
}