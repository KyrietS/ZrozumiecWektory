class Wall
{
  public ArrayList< PVector > vertices = new ArrayList< PVector > ();
  color col = 120;
  int id;
  
  public Wall( int id )
  {
    this.id = id;
  }
  
  public void addVertex( float x, float y )
  {
    if( x < 50 ) x = 50;
    if( x > 850 ) x = 850;
    if( y < 50 ) y = 50;
    if( y > 850 ) y = 850;
    vertices.add( new PVector( x, y ) );
  }
  
  public void show( color col )
  {
    beginShape();
    fill( col );
    for( PVector vertex : vertices )
    {
      vertex( vertex.x, vertex.y );
    }
    endShape( CLOSE );
  }
  
  public void showId()
  {
    fill( 0, 0, 255 );
    if( vertices.size() > 0 )
      text( Integer.toString( id+1 ), vertices.get( 0 ).x, vertices.get( 0 ).y );
  }
}