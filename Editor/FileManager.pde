// ----------------------------------------------- //
// Klasa obsługująca zapis / odczyt plików JSON
// ----------------------------------------------- //
class FileManager
{
  // ----------------------------------- //
  // Zapis poziomu do pliku level.json
  // ----------------------------------- //
  void saveLevel()
  { 
    JSONObject level = new JSONObject();
    //**************ZAPIS SCIAN*****************
    JSONArray wallsJS = new JSONArray();
    JSONObject wall;
    JSONArray vertices;
    JSONObject vertex;
    
    for( int i = 0; i < walls.size()-1; i++ )
    {
      wall = new JSONObject();
      vertices = new JSONArray();
      // --------- ID ----------
      wall.setInt("id", i+1);
      // -------- KOLOR --------
      wall.setInt("r", 10);
      wall.setInt("g", 10);
      wall.setInt("b", 10);
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
    for(int k = 0;k<texts.size();k++)
    {
      text=new JSONObject();
      text.setString("content",texts.get(k).content);
      text.setFloat("rotation",texts.get(k).rotation);
      text.setFloat("size",texts.get(k).size/8);
      text.setFloat("x",texts.get(k).x/8);
      text.setFloat("y",texts.get(k).y/8);
      textsJS.setJSONObject(k,text);
    }
    level.setJSONArray("texts",textsJS);
    //*************KONIEC ZAPISU TEKSTOW***********
    saveJSONObject( level, "level.json" );
  }
}