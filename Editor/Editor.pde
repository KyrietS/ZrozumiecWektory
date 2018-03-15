
ArrayList< Wall > walls = new ArrayList< Wall > ();
FileManager fileManager = new FileManager();

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
    fileManager.saveLevel();
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