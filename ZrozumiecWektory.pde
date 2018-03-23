// Tytuł projektu + autorzy

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
  background( 100 );
  translate( (width-height)/2, 0 );
  engine.update();
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
    case KeyEvent.VK_SPACE: ActiveKey.SPACE = true; break;
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
    case KeyEvent.VK_SPACE: ActiveKey.SPACE = false; break;
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
  static boolean SPACE = false;
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
  textSize( m2p(1) );
  fill( 0 );
  text( "FPS: " + _frameRate, m2p(45), m2p(99) );
  
}