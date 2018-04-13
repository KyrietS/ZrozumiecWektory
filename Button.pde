// Tytuł projektu + autorzy

// ------------------------------------------------------------- //
// Zbiór klas do tworzenia ładnego interfejsu użytkownika :)
// --------------------------------------------------------------//

class ButtonEvent extends RuntimeException
{
  String buttonID;
  ButtonEvent( String buttonID ){ this.buttonID = buttonID; }
  String getMessage(){ return buttonID; }
}

class Button
{
  PVector pos;
  PVector size;
  color col;
  String content;
  final String id;
  private float fontSize;
  
  Button( String id, String content, float x, float y, float sizeX, float sizeY, color col )
  {
    this.id = id;
    this.content = content;
    this.pos = new PVector( m2p(x),m2p(y) );
    this.size = new PVector( m2p(sizeX), m2p(sizeY) );
    this.col = col;
    fontSize = 0.5*m2p(sizeY);
  }
  
  private int delay = 0;
  void show() throws ButtonEvent
  {
    // ---- Sprawdzanie czy kursor jest nad przyciskiem --- //
    boolean hover = false;
    boolean clicked = false;
    if( mouseHover() )
      if( mousePressed )
        clicked = true;
      else
        hover = true;
    
    if( clicked == true )
      fill( lerpColor( col, #000000, 0.3 ) );
    else if( hover == true && clicked == false )
      fill( lerpColor( col, #000000, 0.6 ) );
    else    
      fill( col );
    stroke( lerpColor( col, #000000, 0.4 ) );
    strokeWeight( m2p(0.2) );
    rect( pos.x, pos.y, size.x, size.y );
    if( hover == true ) fill( 255 );
    else fill( 0 );
    textSize( fontSize );
    text( content, pos.x + 0.05*size.x, pos.y + (size.y+0.8*fontSize)/2 );
    stroke( 0 );
    strokeWeight( 1 );
    if( clicked && (millis()-delay) > 200 )
    {
      delay = millis();
      throw new ButtonEvent( id );
    }
    clicked = false;
  }
  
  private boolean mouseHover()
  {
    if( (mouseX - (width-height)/2 >= pos.x && mouseX - (width-height)/2 <= pos.x + size.x) && (mouseY >= pos.y && mouseY <= pos.y + size.y) )
      return true;
    else
      return false;
  }
}