class Player
{
  private PVector pos;
  private int radius = 50;
  private color fillColor = #FFF600;
  private PVector targetVector = new PVector(0, 0);
  private PVector realVector = new PVector(0, 0);
  private PVector velocity = new PVector(0, 0);
  private Level.Settings settings;
  
  Player( Level.Settings settings )
  {
    this.settings = settings;
    pos = new PVector( settings.startPos.x, settings.startPos.y );
  }
  public void show()
  {
    fill( fillColor );
    ellipse( pos.x, pos.y, radius, radius );
    fill( 255 ); // przywróć domyślne ustawienie
    showVectors();
  }
  public void move()
  {
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
  }
  public void addHorizontal( float vec )
  {
    targetVector.x += vec;
  }
  public void addVertical( float vec )
  {
    targetVector.y += vec;
  }
  public void changeVectors()
  {
    realVector.x = targetVector.x;
    realVector.y = targetVector.y;
    targetVector.x = 0;
    targetVector.y = 0;
  }
  private void showVectors()
  {
    // --- wektory normalne ---
    drawArrow( pos.x, pos.y, pos.x + realVector.x, pos.y, #4286f4 );
    drawArrow( pos.x, pos.y, pos.x, pos.y + realVector.y, #4286f4 );
    // TODO: Kolor wektora zależny od rodzaju wektora.
    // --- wektory docelowe ---
    drawArrow( pos.x, pos.y, pos.x + targetVector.x, pos.y, #FF0000 );
    drawArrow( pos.x, pos.y, pos.x, pos.y + targetVector.y, #FF0000 );
    
  }
  private void drawArrow(float x1, float y1, float x2, float y2, color col ) 
  {
    fill( col );
    stroke( col );
    float a = sqrt(dist(x1, y1, x2, y2) / 2 );
    strokeWeight( sqrt( 4*a ) );
    pushMatrix();
    translate(x2, y2);
    rotate(atan2(y2 - y1, x2 - x1));
    triangle(- a * 2 , - a, 0, 0, - a * 2, a);
    popMatrix();
    line(x1, y1, x2, y2);  
    fill( 255 );
    stroke( 0 );
    strokeWeight( 1 );
  }
}