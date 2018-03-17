// Tytuł projektu + autorzy

// ------------------------------------------------------------- //
// Zbiór klas do tworzenia ładnego interfejsu użytkownika :)
// --------------------------------------------------------------//


class GUI
{
  Button menuButton = new Button( "  MENU", m2p(0.5), m2p(0.4), m2p(6.5), m2p(3.2), #c1d9ff);
  Button statsButton = new Button( "  STATYSTYKI", m2p(88), m2p(0.4), m2p(10.5), m2p(3.2), #c1d9ff);
  
  private PFont bloggerSans;
  private PFont bloggerSansBold;
  
  void infoBar()
  {
    fill( #77abff );
    rect( 0,0, m2p( mapSize ), m2p(4) );
    
    textFont( bloggerSans );
    menuButton.show();
    statsButton.show();
  }
  
  GUI()
  {
    bloggerSans = createFont("data/fonts/BloggerSans.ttf", 12);
    bloggerSansBold = createFont("data/fonts/BloggerSans-Bold.ttf", 12);
  }
}

class Button
{
  PVector pos;
  PVector size;
  color col;
  String content;
  private float fontSize;
  
  Button( String content, float x, float y, float sizeX, float sizeY, color col )
  {
    this.content = content;
    this.pos = new PVector( x,y );
    this.size = new PVector( sizeX, sizeY );
    this.col = col;
    fontSize = 0.5*sizeY;
  }
  
  void show()
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