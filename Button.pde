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


// ------------------------------------------------------------- //
// Zbiór klas do tworzenia ładnego interfejsu użytkownika :)
// --------------------------------------------------------------//

static private boolean buttonPressed = false;

class ButtonEvent extends RuntimeException
{
  String buttonID;
  ButtonEvent( String buttonID ){ this.buttonID = buttonID; }
  String getMessage(){ return buttonID; }
}

class Button
{
  public PVector pos;
  public PVector size;
  public color col;        // Kolor tła przycisku.
  public String content;
  public boolean isBold = false;
  public boolean isActive = true;
  final String id;
  private float fontSize;
  private color fontColor1 = 0;
  private color fontColor2 = 255;
  
  Button( String id, String content, float x, float y, float sizeX, float sizeY, color col )
  {
    this.id = id;
    this.content = content;
    this.pos = new PVector( x , y );
    this.size = new PVector( sizeX, sizeY );
    this.col = col;
    fontSize = 0.5*sizeY;
  }
  
  private int delay = 0;
  public void show() throws ButtonEvent
  {
    // ---- Sprawdzanie czy kursor jest nad przyciskiem --- //
    boolean hover = false;
    boolean clicked = false;
    if( mouseHover() && isActive )
      if( mousePressed && buttonPressed == false )
      {
        clicked = true;
        buttonPressed = true;
      }
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
    if( hover == true ) fill( fontColor2 );
    else fill( fontColor1 );
    if( isBold == true ) textFont( bloggerSansBold );
    else textFont( bloggerSans );
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
  
  public void setFontColor( color fontColor1, color fontColor2 )
  {
    this.fontColor1 = fontColor1;
    this.fontColor2 = fontColor2;
  }
  
  private boolean mouseHover()
  {
    if( (mouseX - (width-height)/2 >= pos.x && mouseX - (width-height)/2 <= pos.x + size.x) && (mouseY >= pos.y && mouseY <= pos.y + size.y) )
      return true;
    else
      return false;
  }
}

class ImageLink
{
  PImage img;
  float x, y, _width, _height;
  String url;
  ImageLink( String url, String imagePath, float x, float y, float _width, float _height )
  {
    this.url = url;
    img = loadImage( imagePath );
    this.x = x;
    this.y = y;
    this._width = _width;
    this._height = _height;
  }
  
  void show()
  {
    image( img, x, y, _width, _height ); 
    if( mouseHover() )
    {
      noFill();
      stroke( 0 );
      strokeWeight( 1 );
      cursor = HAND;
      rect( x, y, _width, _height );
      if( mousePressed && buttonPressed == false )
      {
        link( url );
        buttonPressed = true;
      }
    }
    
  }
  
  private boolean mouseHover()
  {
    if( (mouseX - (width-height)/2 >= x && mouseX - (width-height)/2 <= x + _width) && (mouseY >= y && mouseY <= y + _height) )
      return true;
    else
      return false;
  }
}
