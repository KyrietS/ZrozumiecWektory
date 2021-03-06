/**********************************************************/
/*          Z R O Z U M I E Ć   W E K T O R Y             */
/* Projekt na kurs "Fizyka dla informatyków".             */
/* Realizowany przez studentów  informatyki,              */
/* na Wydziale Podstawowych Problemów Techniki,           */
/* na Politechnice Wrocławskiej.                          */
/* Skład zespołu: Sebastian Fojcik, Bartosz Stajnowski,   */
/* Piotr Andrzejewski, Mateusz Trzeciak.                  */
/* Dozwolone jest wprowadzanie własnych zmian.            */
/* Program należy zawsze rozpowszechniać wraz z kodem     */
/* źródłowym, z poszanowaniem autorów utworu pierwotnego. */
/*                                                        */
/* Projekt powstał dzięki narzędziom udostępnionym przez  */
/* Processing: https://processing.org                     */
/**********************************************************/

import java.awt.event.KeyEvent;

GameEngine engine;

final float mapSize = 100;   // Rozmiar mapy w metrach 

void setup()
{
  fullScreen();
  frameRate( 60 );
  engine = new GameEngine();
}

void draw()
{
  background( #808080 );
  translate( (width-height)/2, 0 );
  noFill();
  
  engine.update();
  
  if( engine.settings.getDeveloperMode() )
    printDebugInfo();
}

void keyPressed()
{
  switch( keyCode )
  {
    case KeyEvent.VK_W: ActiveKey.W = true; break;
    case KeyEvent.VK_A: ActiveKey.A = true; break;
    case KeyEvent.VK_S: ActiveKey.S = true; break;
    case KeyEvent.VK_D: ActiveKey.D = true; break;
    case KeyEvent.VK_UP: ActiveKey.UP = true; break;
    case KeyEvent.VK_DOWN: ActiveKey.DOWN = true; break;
    case KeyEvent.VK_LEFT: ActiveKey.LEFT = true; break;
    case KeyEvent.VK_RIGHT: ActiveKey.RIGHT = true; break;
    case KeyEvent.VK_SPACE: ActiveKey.SPACE = true; break;
    case KeyEvent.VK_SHIFT: ActiveKey.SHIFT = true; break;
    case KeyEvent.VK_R: ActiveKey.R = true; break;
  }
}

void keyReleased()
{
  switch( keyCode )
  {
    case KeyEvent.VK_W: ActiveKey.W = false; break;
    case KeyEvent.VK_A: ActiveKey.A = false; break;
    case KeyEvent.VK_S: ActiveKey.S = false; break;
    case KeyEvent.VK_D: ActiveKey.D = false; break;
    case KeyEvent.VK_UP: ActiveKey.UP = false; break;
    case KeyEvent.VK_DOWN: ActiveKey.DOWN = false; break;
    case KeyEvent.VK_LEFT: ActiveKey.LEFT = false; break;
    case KeyEvent.VK_RIGHT: ActiveKey.RIGHT = false; break;
    case KeyEvent.VK_SPACE: ActiveKey.SPACE = false; break;
    case KeyEvent.VK_SHIFT: ActiveKey.SHIFT = false; break;
    case KeyEvent.VK_R: ActiveKey.R = false; break;
  }
}

// ---------------------------------------------------
//  Lista obecnie obsługiwanych przycisków
// ---------------------------------------------------
public static class ActiveKey
{
  static boolean W = false;
  static boolean A = false;
  static boolean S = false;
  static boolean D = false;
  static boolean UP = false;
  static boolean DOWN = false;
  static boolean LEFT = false;
  static boolean RIGHT = false;
  static boolean SPACE = false;
  static boolean SHIFT = false;
  static boolean R = false;
}

// ------ FUNKCJE POMOCNICZE ------ //
float p2m( float p ){ return (p*mapSize)/height; }            // Zamienia wielkość w pikselach na przeskalowaną liczbę metrów.
float m2p( float m ){ return (m*height)/mapSize; }            // Zamienia liczbę metrów na przeskalowaną ilość pikseli.

// ---------------------------------------------------
//  Informacje pomocnicze (Debug Info)
// ---------------------------------------------------
float _frameRate = 0;
float _debugTimer = 0;
void printDebugInfo()
{
  
  if( millis() - _debugTimer > 500 ) // Odświeżaj co sekundę, nie częściej.
  {
    _frameRate = frameRate;
    _debugTimer = millis();
  }
  textFont( bloggerSans );
  textSize( m2p(1.5) );
  fill( 0 );
  text( "FPS: " + _frameRate, m2p(45), m2p(99) );
  text( "Tryb deweloperski", m2p(88), m2p(99) );
}

void mouseReleased()
{
  buttonPressed = false;
}
