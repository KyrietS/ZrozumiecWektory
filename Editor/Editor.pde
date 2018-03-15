//ArrayList< ArrayList< PVector > > wallsArray = new ArrayList< ArrayList< PVector > >();
ArrayList< Wall > walls = new ArrayList< Wall > ();

void setup()
{
  size( 900, 900 );
  walls.add( new Wall( 0 ) );
  textSize( 32 );
}

void draw()
{
  background( 200 );
  fill( 230 );
  rect( 50, 50, 800, 800 );
  showWalls();
  fill( 255 );
  text( "Ścian: " + (walls.size()-1), 30, 40 );
}

void mousePressed()
{
  if( mouseButton == LEFT )
    //addVertex( mouseX, mouseY );
    walls.get( walls.size()-1 ).addVertex( mouseX, mouseY );
}

void keyPressed()
{
  if( key == ' ' )
    walls.add( new Wall( walls.size() ) );
  if( key == 's' || key == 'S' )
    saveLevel();
}

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

void showWalls()
{
  // ----- RYSOWANIE ŚCIAN (OSTATNIA CZERWONA) ------
  for( int i = 0; i < walls.size(); i++ )
  {
    if( i == walls.size() -1 )
      walls.get( i ).show( #FFAFAF );
    else
      walls.get( i ).show( 120 );
  }
  
  for( Wall wall : walls )
    wall.showId();
}