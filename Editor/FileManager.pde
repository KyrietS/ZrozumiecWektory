// ----------------------------------------------- //
// Klasa obsługująca zapis / odczyt plików JSON
// ----------------------------------------------- //
class FileManager
{
  // -----------------------------------
  // Zapis poziomu do pliku level.json
  // -----------------------------------
  void saveLevel()
  { 
    JSONObject level = new JSONObject();
    saveWalls( level );
    saveTexts( level );
    saveSettings( level );
    saveFinish( level );
    saveJSONObject( level, "level.json" );
  }
  
  // -----------------------------------
  // Odczyt poziomu z pliku level.json
  // -----------------------------------
  void loadLevel()
  {
    // TODO
  }
  
  
// -----------------------------------------------------
//        ZAPISYWANIE ŚCIAN
// -----------------------------------------------------
  private void saveWalls( JSONObject level )
  {
    JSONArray wallsJS = new JSONArray();
    JSONObject wall;
    JSONArray vertices;
    JSONObject vertex;
    
    for( int i = 0; i < walls.size(); i++ )
    {
      wall = new JSONObject();
      vertices = new JSONArray();
      // --------- ID ----------
      wall.setInt("id", i+1);
      // -------- KOLOR --------
      wall.setString("color", hex(walls.get(i).col) );
      // ------------------------
      // -- WSPÓŁRZĘDNE ŚCIANY --
      for( int j = 0; j < walls.get( i ).vertices.size(); j++ )
      {
        vertex = new JSONObject();
        vertex.setFloat( "x", (walls.get(i).vertices.get( j ).x-50)/8 );
        vertex.setFloat( "y", (walls.get(i).vertices.get( j ).y-50)/8 );
        vertices.setJSONObject(j,vertex);
      }
      wall.setJSONArray("vertices", vertices);
      // ------------------------
      // -------- ŚCIANA --------
      wallsJS.setJSONObject(i, wall);
    }
   
    level.setJSONArray("walls", wallsJS);
  }
// -----------------------------------------------------
//        ZAPISYWANIE NAPISÓW
// -----------------------------------------------------
  private void saveTexts( JSONObject level )
  {
    JSONArray textsJS=new JSONArray();
    JSONObject text;
    for(int i = 0;i<texts.size();i++)
    {
      text=new JSONObject();
      text.setString("content",texts.get(i).content);
      text.setFloat("font-size",texts.get(i).size/8);
      text.setFloat("rotation",texts.get(i).rotation);
      text.setString("color", hex(texts.get(i).col) );
      text.setFloat("x",(texts.get(i).x-50)/8);
      text.setFloat("y",(texts.get(i).y-50)/8);
      textsJS.setJSONObject(i,text);
    }
    level.setJSONArray("texts",textsJS);
  }
// -----------------------------------------------------
//        ZAPISYWANIE USTAWIEŃ
// -----------------------------------------------------
  private void saveSettings( JSONObject level )
  {
    JSONObject jSettings = new JSONObject();
    
    jSettings.setString("name", settings.name );
    jSettings.setString("description", settings.description);
    
    jSettings.setString("horizontal-vector-type",settings.horizontalVectorType);
    jSettings.setFloat("horizontal-vector-max", settings.horizontalVectorMax);
    jSettings.setFloat("horizontal-vector-min", settings.horizontalVectorMin);
    
    jSettings.setString("vertical-vector-type", settings.verticalVectorType);
    jSettings.setFloat("vertical-vector-max", settings.verticalVectorMax);
    jSettings.setFloat("vertical-vector-min", settings.verticalVectorMin);
    
    jSettings.setInt("spaces-limit", settings.spacesLimit);
    jSettings.setInt("time-limit", settings.timeLimit);
    
    JSONObject startPos = new JSONObject();
    startPos.setFloat("x", settings.startPos.x);
    startPos.setFloat("y", settings.startPos.y);
    jSettings.setJSONObject("start-pos", startPos);
    
    level.setJSONObject("settings",jSettings);
  }
// -----------------------------------------------------
//        ZAPISYWANIE METY
// -----------------------------------------------------
  private void saveFinish( JSONObject level )
  {
    JSONObject jFinish = new JSONObject();
    jFinish.setString("color", hex(finish.col));
    JSONArray vertices = new JSONArray();
    for( int i = 0; i < finish.vertices.size(); i++ )
    {
      JSONObject vertex = new JSONObject();
      vertex.setFloat("x", finish.vertices.get(i).x );
      vertex.setFloat("y", finish.vertices.get(i).y );
      vertices.setJSONObject( i , vertex );
    }
    jFinish.setJSONArray("vertices", vertices);
    
    level.setJSONObject("finish", jFinish );
  }
  
}