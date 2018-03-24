
ArrayList<Text> texts= new ArrayList<Text>();
ArrayList< Wall > walls = new ArrayList< Wall > ();
Settings settings = new Settings();
Wall finish = new Wall(0);

FileManager fileManager = new FileManager();
boolean textMode = false;
boolean wallUnderConstruction = false;                    // Zmienna jest 'true', gdy jakaś ściana jest w trakcie konstrukcji (czerwona ściana)

void setup()
{
  size( 900, 900 );
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
    texts.add( new Text( mouseX, mouseY, #000000 ) );
  else if( mouseButton == LEFT )                       // LPM w trybie ścianowym dodaje nową ścianę lub wierzchołek.
    if( wallUnderConstruction == true )
      walls.get( walls.size()-1 ).addVertex( mouseX, mouseY );     // Jeśli ściana w trakcie konstrukcji, to dodaj nowy wierzchołek.
    else
    {
      walls.add( new Wall( walls.size()+1 ) );
      walls.get( walls.size()-1 ).addVertex( mouseX, mouseY );      // Jeśli żadna ściana nie jest budowana, to stwórz nową.
      wallUnderConstruction = true;
    }
}

void keyPressed()
{
  switch( keyCode )
  {
    case KeyEvent.VK_F1:                                // Wciśnięcie F1 przełącza w tryb tekstowy.
    
      textMode = !textMode;
      break;
      
    case KeyEvent.VK_F5:                                // Przycisk F5 zapisuje plik.
      showVanishingInfo( "Zapisano plik" );
      fileManager.saveLevel();
      break;
      
    case KeyEvent.VK_F8:
      showVanishingInfo( "Wczytano plik" );
      fileManager.loadLevel();
      break;
      
      
    case KeyEvent.VK_DELETE:                            // Przycisk DELETE usuwa ostatnio dodany element. (Trzeba być w odpowiednim trybie)
      if( textMode == true && texts.size() > 0)         // DELETE w trybie tekstowym usuwa ostatnio dodany napis
        texts.remove( texts.size()-1 );
      else if( textMode == false && walls.size() > 0 )
        if( wallUnderConstruction == true )             // Jeśli ściana jest budowana...
          if( walls.get(walls.size()-1).vertices.size() == 1 ) // i ma jeden wierzchołek, to usuń całą ścianę (ściana bez wierzchołków nie istnieje)
          {
            walls.remove( walls.size()-1 );
            wallUnderConstruction = false;
          }
          else                                                 // w przeciwnym przypadku usuń tylko ostatnio dodany wierzchołek.
            walls.get( walls.size()-1 ).vertices.remove( walls.get( walls.size()-1 ).vertices.size() - 1 );
        else                                            // Jeśli żadna ściana nie jest budowana, to usuń całą ostatnio dodaną ścianę.
          walls.remove( walls.size() - 1 );
  }

  if( textMode == true && texts.size() > 0 )      // Przechwytywanie Page Up/Down oraz strzałek.
  {
    texts.get( texts.size()-1 ).move( keyCode );
    texts.get( texts.size()-1 ).setSize( keyCode );
  }
  else if( key == ' ' )                                // Spacja w trybie ścianowym zatwierdza ścianę.
    wallUnderConstruction = false;
  
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
    if( i == walls.size() -1 && wallUnderConstruction == true )
      walls.get( i ).show( #FFAFAF );
    else
      walls.get( i ).show();
  }
  finish.show();
  
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
float infoDelay = 0;                                      // Aby napis "Zapisano plik" wyświetlał się przez 3 sek.
String vanishingInfo;                                     // Napis, który będzie przez 3 sek. wyświetlany na dole ekranu.

void showInfo()
{
  fill( 0 );
  ellipse( mouseX, mouseY, 4, 4 );
  text( "Ścian: " + (walls.size()), 20, 40 );
  text( "Napisów: " + (texts.size()), 20, 890 );
  text( "Tryb: " + (textMode ? "tekstowy" : "ścianowy"), 200, 40 );
  if( infoDelay != 0 && millis() - infoDelay <= 3000 )
    text( vanishingInfo, 700, 890 );
}

void showVanishingInfo( String info )
{
  infoDelay = millis();
  vanishingInfo = info;
}