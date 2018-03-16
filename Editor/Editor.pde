
ArrayList<Text> texts= new ArrayList<Text>();
ArrayList< Wall > walls = new ArrayList< Wall > ();
FileManager fileManager = new FileManager();
boolean textIsEntered=false;
boolean newLetter = true;


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
  showTexts();
  
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
  if(newLetter==true)
  {
    if(textIsEntered == true)
    {
      if(keyCode == CONTROL)
      {
        textIsEntered = false;
      }
      else
      {
        texts.get(texts.size() - 1).AddLetter(key);
      }
    }
    else if (textIsEntered == false)
    {
      if(keyCode==CONTROL)
      {
        texts.add(new Text(mouseX,mouseY,#005555));
        textIsEntered=true;
      }
      if( key == ' ' )
          walls.add( new Wall( walls.size() ) );
      if( key == 's' || key == 'S' )
          fileManager.saveLevel();
    }
    newLetter=false;
  }
  
}
void keyReleased()
{
  newLetter = true;
}

void showTexts()
{
  if(texts.size()>0)
  {
    for(Text temp : texts)
    {
       temp.show();
    }
  }
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
