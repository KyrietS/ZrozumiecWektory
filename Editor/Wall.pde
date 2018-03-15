class Wall
{
  public ArrayList< PVector > vertices = new ArrayList< PVector > ();    // Tablica wierzchołków ściany
  color col = 120;                                                       // Kolor wypełnienia ściany
  int id;                                                                // Unikalny numer ID ściany
  
  // ----- KONSTRUKTOR ----- //
  public Wall( int id )
  {
    this.id = id;
  }
  
  // -------------------------------- //
  // Dodaje wierzchołek do ściany     //
  // -------------------------------- //
  public void addVertex( float x, float y )
  {
    if( x < 50 ) x = 50;
    if( x > 850 ) x = 850;
    if( y < 50 ) y = 50;
    if( y > 850 ) y = 850;
    vertices.add( new PVector( x, y ) );
  }
  
  // --------------------------------------------------- //
  // Wyświetla ścianę na ekranie z wypełnieniem col      //
  // --------------------------------------------------- //
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
  
  // ------------------------------------ //
  // Wyświetla numerek z ID na figurze    //
  // ------------------------------------ //
  public void showId()
  {

    if( vertices.size() == 0 )
      return;
    fill( 0, 0, 255 );
    PVector idCoord = new PVector(0, 0);
    for( PVector vertex : vertices )
    {
      idCoord.x += vertex.x;
      idCoord.y += vertex.y;
    }
    idCoord.x /= vertices.size();
    idCoord.y /= vertices.size();
  
    text( Integer.toString( id+1 ), idCoord.x, idCoord.y );
  }
}