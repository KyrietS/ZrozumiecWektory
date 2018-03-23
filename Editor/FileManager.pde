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
    try
    {
      JSONObject level = loadJSONObject( "level.json" );
      loadWalls( level );
      loadTexts( level );
      loadSettings( level );
      loadFinish( level );
    }
    catch( Exception e )
    {
      showVanishingInfo( "Błąd odczytu!" );
    }
    
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
      wall.setInt("id", walls.get(walls.size()-1).id );
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
  
// -----------------------------------------------------
//        WCZYTYWANIE ŚCIAN
// -----------------------------------------------------
  private void loadWalls( JSONObject level )
  {
    walls.clear();
    JSONArray jWalls = level.getJSONArray("walls");
    for( int i = 0; i < jWalls.size(); i++ )
    {
      JSONObject wall = jWalls.getJSONObject( i );
      walls.add( new Wall( wall.getInt("id") ) );
      walls.get( i ).col =  unhex( wall.getString("color") );
      JSONArray vertices = wall.getJSONArray("vertices");
      for( int j = 0; j < vertices.size(); j++ )
      {
        JSONObject vertex = vertices.getJSONObject( j );
        float x = vertex.getFloat("x")*8 + 50;
        float y = vertex.getFloat("y")*8 + 50;
        walls.get( i ).vertices.add( new PVector( x, y ) );
      }
    }
  }
// -----------------------------------------------------
//        WCZYTYWANIE NAPISÓW
// -----------------------------------------------------
  private void loadTexts( JSONObject level )
  {
    texts.clear();
    JSONArray jTexts = level.getJSONArray("texts");
    for( int i = 0; i < jTexts.size(); i++ )
    {
      JSONObject text = jTexts.getJSONObject( i );
      color col = unhex( text.getString("color") );
      float x = text.getFloat("x")*8 + 50;
      float y = text.getFloat("y")*8 + 50;
      texts.add( new Text( x, y, col ) );
      texts.get( i ).content = text.getString("content");
      texts.get( i ).size = text.getFloat( "font-size" )*8;
      texts.get( i ).rotation = text.getFloat( "rotation" );
    }
  }
// -----------------------------------------------------
//        WCZYTYWANIE USTAWIEŃ
// -----------------------------------------------------
  private void loadSettings( JSONObject level )
  {
    JSONObject jSettings = level.getJSONObject("settings");
    settings.name = jSettings.getString("name");
    settings.description = jSettings.getString("description");
    settings.horizontalVectorType = jSettings.getString("horizontal-vector-type");
    settings.horizontalVectorMax = jSettings.getFloat("horizontal-vector-max");
    settings.horizontalVectorMin = jSettings.getFloat("horizontal-vector-min");
    settings.verticalVectorType = jSettings.getString("vertical-vector-type");
    settings.verticalVectorMax = jSettings.getFloat("vertical-vector-max");
    settings.verticalVectorMin = jSettings.getFloat("vertical-vector-min");
    settings.spacesLimit = jSettings.getInt("spaces-limit");
    settings.timeLimit = jSettings.getInt("time-limit");
    JSONObject startPos = jSettings.getJSONObject("start-pos");
    settings.startPos.x = startPos.getFloat("x");
    settings.startPos.y = startPos.getFloat("y");
  }
// -----------------------------------------------------
//        WCZYTYWANIE METY
// -----------------------------------------------------
  private void loadFinish( JSONObject level )
  {
    finish = new Wall( 0 );
    JSONObject jFinish = level.getJSONObject("finish");
    finish.col = unhex(jFinish.getString("color"));
    JSONArray vertices = jFinish.getJSONArray("vertices");
    for( int i = 0; i < vertices.size(); i++ )
    {
      JSONObject vertex = vertices.getJSONObject( i );
      float x = vertex.getFloat("x")*8 + 50;
      float y = vertex.getFloat("y")*8 + 50;
      finish.vertices.add( new PVector( x, y ) );
    }
  }
  
}