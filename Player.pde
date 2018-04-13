// Tytuł projektu + autorzy

// Reprezentacja kulki gracza na ekranie gry.
class Player
{
// ------------------- USTAWIENIA PLAYERA ------------------- //
  private PVector pos;                                        // Pozycja gracza na mapie (w pikselach).
  private float radius = 3;                                   // Promień kulki gracza (w pikselach). TYMCZASOWO wpisane ręcznie
  public color fillColor = #FFF600;                           // Kolor wypełnienia kulki. TYMCZASOWO! public
  private PVector targetVector = new PVector(0, 0);           // Współrzędne wektora docelowego (w piskelach).
  private PVector realVector = new PVector(0, 0);             // Współrzędne wektora rzeczywistego (w pikselach).
  private PVector velocity = new PVector(0, 0);               // Współrzędne wektora prędkości wypadkowej (w pikselach).
  private Level.Settings settings;                            // Referencja do ustawień poziomu.
  private PFont vectorFont;                                   // Czcionka użyta do wyświetlania wartości przy wektorach.
  private int spaceHitCounter = 0;                            // Zlicza liczbę wciśniętych spacji.
  private boolean isFrozen = false;                           // Czy gracz ma przestać się poruszać (zamrożony).
// -----------------------------------------------------------//
  
// ------------- KONSTRUKTOR -------------
  Player()
  {
    this.settings = level.settings;
    pos = new PVector( settings.startPos.x, settings.startPos.y );
    vectorFont = createFont("data/fonts/BloggerSans-Bold.ttf", 12);
    radius = m2p(radius);
  }
// ---------------------------------------
// Wyświetlanie gracza na ekranie.
// ---------------------------------------
  public void show()
  {
    fill( fillColor );
    ellipse( pos.x, pos.y, 2*radius, 2*radius );
    fill( 255 ); // przywróć domyślne ustawienie
    showVectors();
  }
// ---------------------------------------------------
// Wykonanie ruchu zgodnego z wektorem rzeczywistym.
// ---------------------------------------------------
  public void move()
  {
    if( isFrozen )  // Zamrożony gracz się nie porusza.
      return;
      
    // --- HROIZONTALS ---
    if( settings.horizontalVectorType == VectorType.DISPLACEMENT )
    {
      pos.x = pos.x + realVector.x;
      realVector.x = 0;
    }
    if( settings.horizontalVectorType == VectorType.VELOCITY )
    {
      pos.x = pos.x + realVector.x / frameRate;
    }
    if( settings.horizontalVectorType == VectorType.ACCELERATION )
    {
      pos.x = pos.x + velocity.x / frameRate;
      velocity.x = velocity.x + realVector.x / frameRate;
    }
    // --- VERTICALS ---
    if( settings.verticalVectorType == VectorType.DISPLACEMENT )
    {
      pos.y = pos.y + realVector.y;
      realVector.y = 0;
    }
    if( settings.verticalVectorType == VectorType.VELOCITY )
    {
      pos.y = pos.y + realVector.y / frameRate;
    }
    if( settings.verticalVectorType == VectorType.ACCELERATION )
    {
      pos.y = pos.y + velocity.y / frameRate;
      velocity.y = velocity.y + realVector.y / frameRate;
    }
    
    if( hitWall() )
    {
      isFrozen = true;
      throw new HitWallException();
    }
    if( hitFinish() )
      throw new HitFinishException();
  }
// ---------------------------------------
// Zmiana wektora docelowego w poziomie.
// ---------------------------------------
  public void addHorizontal( float vec )
  {
    if( abs(targetVector.x) < settings.horizontalVectorMin )
      targetVector.x = (targetVector.x+vec < 0 ? -settings.horizontalVectorMin : settings.horizontalVectorMin);
    if( abs(targetVector.x + vec) < settings.horizontalVectorMin )
      targetVector.x = (targetVector.x+vec < 0 ? settings.horizontalVectorMin : -settings.horizontalVectorMin);
    else if( abs(targetVector.x + vec) > settings.horizontalVectorMax )
      targetVector.x = (targetVector.x+vec < 0 ? -settings.horizontalVectorMax : settings.horizontalVectorMax);
    else targetVector.x += vec;
  }
// ---------------------------------------
// Zmiana wektora docelowego w pionie.
// ---------------------------------------
  public void addVertical( float vec )
  {
    if( abs(targetVector.y) < settings.verticalVectorMin )
      targetVector.y = (targetVector.y+vec < 0 ? -settings.verticalVectorMin : settings.verticalVectorMin);
    if( abs(targetVector.y + vec) < settings.verticalVectorMin )
      targetVector.y = (targetVector.y+vec < 0 ? settings.verticalVectorMin : -settings.verticalVectorMin);
    else if( abs(targetVector.y + vec) > settings.verticalVectorMax )
      targetVector.y = (targetVector.y+vec < 0 ? -settings.verticalVectorMax : settings.verticalVectorMax);
    else targetVector.y += vec;
  }
// -----------------------------------------------
// Wcielenie w życie zmian z wektora docelowego.
// -----------------------------------------------
  public void changeVectors()
  {
    if( settings.spacesLimit == 0 || spaceHitCounter < settings.spacesLimit )
    {
      realVector.x = targetVector.x;
      realVector.y = targetVector.y;
      targetVector.x = 0;
      targetVector.y = 0;
      spaceHitCounter++;
    }
    
    if( settings.spacesLimit != 0 && spaceHitCounter >= settings.spacesLimit )
    {
      settings.horizontalVectorMax = 0;
      settings.verticalVectorMax = 0;
      settings.horizontalVectorMin = 0;
      settings.verticalVectorMin = 0;
    }
  }
// ---------------------------------------------------------------------
// Wyświetlenie strzałek na ekranie oraz wartości liczbowych przy nich
// ---------------------------------------------------------------------
  private void showVectors()
  {
    textFont( vectorFont );
    textSize( height * 0.01528 );
    // --- wektory normalne ---
    if( realVector.x != 0 ){ 
      fill( 0 );
      float value = (float)round(p2m(realVector.x) * 10)/10;
      text( Float.toString(value) + " m/s", pos.x + realVector.x + (realVector.x < 0 ? -45 : 5), pos.y + 20 ); 
    }
    drawArrow( pos.x, pos.y, pos.x + realVector.x, pos.y, #4286f4 );
    if( realVector.y != 0 ){ 
      fill( 0 );
      float value = (float)round(-p2m(realVector.y) * 10)/10;
      text( Float.toString(value) + " m/s", pos.x - 60, pos.y + realVector.y + (realVector.y>0 ? + 10 : -10) ); 
    }
    drawArrow( pos.x, pos.y, pos.x, pos.y + realVector.y, #4286f4 );
    // TODO: Kolor wektora zależny od rodzaju wektora.
    // --- wektory docelowe ---
    if( targetVector.x != 0 ){ 
      fill( 0 );
      float value = (float)round(p2m(targetVector.x) * 10)/10;
      text( Float.toString(value) + " m/s", pos.x + targetVector.x + (targetVector.x < 0 ? -45 : 5), pos.y - 10 ); 
    }
    drawArrow( pos.x, pos.y, pos.x + targetVector.x, pos.y, #FF0000 );
    if( targetVector.y != 0 ){ 
      fill( 0 );
      float value = (float)round(-p2m(targetVector.y) * 10)/10;
      text( Float.toString(value) + " m/s", pos.x + 10, pos.y + targetVector.y + (targetVector.y>0 ? + 10 : -10) ); 
    }
    drawArrow( pos.x, pos.y, pos.x, pos.y + targetVector.y, #FF0000 );
  }
// -----------------------------------------------------------
// Rysowanie strzałki o kolorze 'col' od (x1,y1) do (x2,y2).
// -----------------------------------------------------------
  private void drawArrow(float x1, float y1, float x2, float y2, color col ) 
  {
    fill( col );
    stroke( col );
    float factor = sqrt(dist(x1, y1, x2, y2) / 2 );
    pushMatrix();
    translate(x2, y2);
    rotate(atan2(y2 - y1, x2 - x1));
    triangle(- factor * 2 , - factor, 0, 0, - factor * 2, factor);
    popMatrix();

    strokeWeight( sqrt( 4*factor ) );
    float d = PVector.dist( new PVector(x1,y1), new PVector(x2,y2) );
    pushMatrix();
    translate( x1, y1 );
    x2 = x2 - x1;
    y2 = y2 - y1;
    line(0, 0, x2*(d-2*factor)/d, y2*(d-2*factor)/d);  
    popMatrix();
    fill( 255 );
    stroke( 0 );
    strokeWeight( 1 );
  }
// ------------------------------------------
// Sprawdzenie czy gracz koliduje ze ścianą.
// ------------------------------------------
  public boolean hitWall()
  {
    for( Level.Wall wall : level.walls )
    {
      if( CollisionSystem.isCollision(wall.vertices,pos,radius) )
        return true;
    }
    return false;
  }
// ------------------------------------------
// Sprawdzenie czy gracz koliduje z metą.
// ------------------------------------------
  public boolean hitFinish()
  {
    if( CollisionSystem.isCollision(level.finish.vertices,pos,radius) )
      return true;
    else
      return false;
  }
  
} // class Player

// ----  WYJĄTKI RZUCANE PRZY KOLIZJI --- //
class HitWallException extends RuntimeException {}                // Uderzenie w ścianę lub wyjście poza mapę.
class HitFinishException extends RuntimeException {}              // Dotknięcie mety.