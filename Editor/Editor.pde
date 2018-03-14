ArrayList< ArrayList< PVector > > wallsArray = new ArrayList< ArrayList< PVector > >();

void setup()
{
  size( 900, 900 );
  wallsArray.add( new ArrayList< PVector >() );
  textSize( 32 );
}

void draw()
{
  background( 200 );
  fill( 230 );
  rect( 50, 50, 800, 800 );
  showWalls();
  fill( 255 );
  text( "Ścian: " + (wallsArray.size()-1), 30, 40 );
}

void mousePressed()
{
  if( mouseButton == LEFT )
    addVertex( mouseX, mouseY );
}

void keyPressed()
{
  if( key == ' ' )
    wallsArray.add( new ArrayList< PVector >() );
  if( key == 's' || key == 'S' )
    saveLevel();
}

void saveLevel()
{ 
  JSONObject level = new JSONObject();
  JSONArray walls = new JSONArray();
  JSONObject wall;
  JSONArray vertices;
  JSONObject vertex;
  
  for( int i = 0; i < wallsArray.size()-1; i++ )
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
    for( int j = 0; j < wallsArray.get( i ).size(); j++ )
    {
      vertex = new JSONObject();
      vertex.setFloat( "x", (wallsArray.get(i).get( j ).x-50)/8 );
      vertex.setFloat( "y", (wallsArray.get(i).get( j ).y-50)/8 );
      vertices.setJSONObject(j+2,vertex);
    }
    wall.setJSONArray("wall", vertices);
    walls.setJSONObject(i, wall);
  }
 
  level.setJSONArray("walls", walls);
  saveJSONObject( level, "level.json" );
}

void addVertex( float x, float y )
{
  if( x < 50 ) x = 50;
  if( x > 850 ) x = 850;
  if( y < 50 ) y = 50;
  if( y > 850 ) y = 850;
  wallsArray.get( wallsArray.size() - 1 ).add( new PVector( x, y ) );
}

void showWalls()
{
  for( int i = 0; i < wallsArray.size(); i++ )
  {
    beginShape();
    if( i == wallsArray.size() -1 )
      fill( #FFAFAF );
    else
      fill( 120 );
    for( PVector vertex : wallsArray.get( i ) )
    {
      vertex( vertex.x, vertex.y );
    }
    endShape( CLOSE );
  }
  
  for( int i = 0; i < wallsArray.size(); i++ )
  {
    fill( 0, 0, 255 );
    if( wallsArray.get( i ).size() > 0 )
      text( Integer.toString( i+1 ), wallsArray.get( i ).get( 0 ).x, wallsArray.get( i ).get( 0 ).y );
  }
}