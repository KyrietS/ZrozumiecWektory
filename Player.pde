class Player
{
  private PVector pos;
  private float radius = 25;
  private color fillColor = #FFF600;
  private PVector targetVector = new PVector(0, 0);
  private PVector realVector = new PVector(0, 0);
  private PVector velocity = new PVector(0, 0);
  private Level.Settings settings;
  private Level level;
  
// ------------- KONSTRUKTOR -------------
  Player( Level level )
  {
    this.settings = level.settings;
    this.level = level;
    pos = new PVector( settings.startPos.x, settings.startPos.y );
  }
// ---------------------------------------
  public void show()
  {
    fill( fillColor );
    ellipse( pos.x, pos.y, 2*radius, 2*radius );
    fill( 255 ); // przywróć domyślne ustawienie
    showVectors();
  }
// ---------------------------------------
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
    
    if( hitWall() )
      throw new HitWallException();
  }
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
// ---------------------------------------
  public void changeVectors()
  {
    realVector.x = targetVector.x;
    realVector.y = targetVector.y;
    targetVector.x = 0;
    targetVector.y = 0;
  }
// ---------------------------------------
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
// ---------------------------------------
  private void drawArrow(float x1, float y1, float x2, float y2, color col ) 
  {
    fill( col );
    stroke( col );
    float factor = sqrt(dist(x1, y1, x2, y2) / 2 );
    strokeWeight( sqrt( 4*factor ) );
    pushMatrix();
    translate(x2, y2);
    rotate(atan2(y2 - y1, x2 - x1));
    triangle(- factor * 2 , - factor, 0, 0, - factor * 2, factor);
    popMatrix();
    line(x1, y1, x2, y2);  
    fill( 255 );
    stroke( 0 );
    strokeWeight( 1 );
  }
// ---------------------------------------
  public boolean hitWall()
  {
    for( Level.Wall wall : level.walls )
    {
      if( collides( wall.vertices ) )
        return true;
    }
    return false;
  }
// ---------------------------------------
  private boolean collides( ArrayList<PVector> vertices )
  {
    if( vertices.size() == 0 )
      return false;
    if( distance( vertices.get( vertices.size()-1 ), vertices.get( 0 ), pos ) < radius )
      return true;
    for( int i = 0; i < vertices.size()-1; i++ )
    {
      if( distance( vertices.get( i ), vertices.get( i + 1 ), pos ) < radius )
        return true;
    }
    return false;
  }
// ---------------------------------------
  private float distance( PVector a, PVector b, PVector p )
  {
    float d2 = PVector.dist(a, b)*PVector.dist(a,b);
    if( d2 == 0.0 )
      return PVector.dist(p, a);
    float t = max(0, min(1, PVector.dot(PVector.sub(p,a), PVector.sub(b,a) ) / d2));
    PVector projection = PVector.add(a, (PVector.mult(PVector.sub(b,a),t ) ));
    return p.dist( projection );
  }
  
} // class Player

class HitWallException extends RuntimeException {}
class HitFinishException extends RuntimeException {}