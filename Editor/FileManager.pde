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
    //**************ZAPIS SCIAN*****************
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
    
    //*************KONIEC ZAPISU SCIAN*************
    //*************ZAPIS TEKSTU********************
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
    //*************KONIEC ZAPISU TEKSTOW***********
    saveJSONObject( level, "level.json" );
  }
  
  // -----------------------------------
  // Odczyt poziomu z pliku level.json
  // -----------------------------------
  void loadLevel()
  {
    // TODO
  }
}