
ArrayList<Text> texts= new ArrayList<Text>();
ArrayList< Wall > walls = new ArrayList< Wall > ();
FileManager fileManager = new FileManager();
boolean textMode = false;

void setup()
{
  size( 900, 900 );
  walls.add( new Wall( 0 ) );
  textSize( 32 );
  textFont( createFont( "../data/fonts/BloggerSans.ttf", 32, true ) );
}

void draw()
{
  background( 200 );
  fill( 230 );
  rect( 50, 50, 800, 800 );
  
  showWalls();
  showTexts();
  showInfo();
}

void mousePressed()
{
  if( textMode == true && mouseButton == LEFT )        // LPM w trybie tekstowym dodaje nowy tekst.
    texts.add( new Text( mouseX, mouseY, 0 ) );
  else if( mouseButton == LEFT )                       // LPM w trybie ścianowym dodaje nową ścianę.
    walls.get( walls.size()-1 ).addVertex( mouseX, mouseY );
}

void keyPressed()
{
  if( keyCode == KeyEvent.VK_F1 )                      // Wciśnięcie F1 przełącza w tryb tekstowy.
    textMode = !textMode;
  else if( textMode == true && texts.size() > 0 )      // Przechwytywanie Page Up/Down oraz strzałek.
  {
    texts.get( texts.size()-1 ).move( keyCode );
    texts.get( texts.size()-1 ).setSize( keyCode );
  }
  else if( key == ' ' )                                // Spacja w trybie ścianowym dodaje nową ścianę.
    walls.add( new Wall( walls.size() ) );
  else if( key == 's' || key == 'S' )                  // Przycisk 'S' w trybie ścianowym zapisuje plik.
    fileManager.saveLevel();
  
}
void keyTyped()                                        // Przechwytywanie liter w trybie tekstowym.
{
  if( textMode == true && texts.size() > 0 )
    texts.get( texts.size()-1 ).addLetter( key );
}
//----------OBROT AKTUALNIE WPISYWANEGO TEKSTU---------------
void mouseWheel(MouseEvent event) 
{
  if( texts.size() > 0 )
    texts.get( texts.size()-1 ).setRotation( event.getCount()/60.0 );
}

// ----- RYSOWANIE ŚCIAN ----- //
void showWalls()
{
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

// ----- RYSOWANIE NAPISÓW ----- //
void showTexts()
{
  for( int i = 0; i < texts.size(); i++ )
  {
    if( i == texts.size()-1 && textMode == true )
      texts.get( i ).show( #0000FF );
    else
      texts.get( i ).show();
  }
}

// ----- RYSOWANIE INFORMACJI NA BRZEGACH EDYTORA ------ //
void showInfo()
{
  fill( 0 );
  text( "Ścian: " + (walls.size()-1), 30, 40 );
  text( "Napisów: " + (texts.size()), 30, 890 );
  text( "Tryb: " + (textMode ? "tekstowy" : "ścianowy"), 250, 40 );
}