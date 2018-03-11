// Tytuł projektu + autorzy

static class CollisionSystem
{
  public static boolean isCollision( ArrayList<PVector> vertices, PVector pos, float radius )
  {
    if( vertices.size() == 0 )
      return false;
    if( checkContaining( vertices, pos ) )
      return true;
    if( distance( vertices.get( vertices.size()-1 ), vertices.get( 0 ), pos ) < radius )
      return true;
    for( int i = 0; i < vertices.size()-1; i++ )
    {
      if( distance( vertices.get( i ), vertices.get( i + 1 ), pos ) < radius )
        return true;
    }
    return false;
  }
  // --- PRIVATE ---
  private static float distance( PVector a, PVector b, PVector p )
  {
        float d2 = PVector.dist(a, b)*PVector.dist(a,b);
    if( d2 == 0.0 )
      return PVector.dist(p, a);
    float t = max(0, min(1, PVector.dot(PVector.sub(p,a), PVector.sub(b,a) ) / d2));
    PVector projection = PVector.add(a, (PVector.mult(PVector.sub(b,a),t ) ));
    return p.dist( projection );
  }
  
    // Temporary variables for checkContaining() and isCrossing().
  private static int k;
  private static PVector r = new PVector();
  private static PVector tmp = new PVector();

  private static boolean checkContaining( ArrayList< PVector > shape, PVector point )
  {
    int  nIntersections = 0;  //number of intersections

    float max_x = 0;

    for ( int i = 0; i < shape.size(); i++ )
    {
      if ( shape.get( i ).x > max_x )
        max_x = shape.get( i ).x;
    }
    r.x = max_x + 1;
    r.y = point.y;


    for ( int i = 0; i<shape.size(); i++ )
    {
      k = i;
      if ( isOnEdge( shape.get( i ), shape.get( (i + 1) % shape.size() ), point ) == true )
      {
        return true;
      }
      if ( isCrossing( shape.get( i ), shape.get( (i + 1) % shape.size() ), shape, point ) == true )
        nIntersections++;
    }
    if ( nIntersections % 2 == 0 )
    {
      return false;
    } else
    {
      return true;
    }
  }
  
  // Support function for isContaining.
  private static boolean isCrossing( PVector a, PVector b, ArrayList< PVector > shape, PVector point )
  {
    if ( (isOnEdge( point, r, a ) == false) && (isOnEdge( point, r, b ) == false) )
    {
      if ( (sign( det( point, r, a ) ) != sign( det( point, r, b ) )) &&
        (sign( det( a, b, point ) ) != sign( det( a, b, r ) )) )
        return true;
      else
        return false;
    } else
    {
      if ( (isOnEdge( point, r, a ) == true) && (isOnEdge( point, r, b ) == true) )
      {
        if ( (sign( det( point, r, shape.get( (k - 1 + shape.size()) % shape.size() ) ) ) == sign( det( point, r, shape.get( (k + 2) % shape.size() ) ) )) &&
          (sign( det( point, r, shape.get( (k - 1 + shape.size()) % shape.size() ) ) ) != 0) )
          return false;
        else
          return true;
      } else
        if ( (isOnEdge( point, r, shape.get( (k - 1 + shape.size()) % shape.size() ) ) == true) || 
          (isOnEdge( point, r, shape.get( (k + 2) % shape.size() ) ) == true) )
          return false;
        else
        {
          if ( isOnEdge( point, r, b ) == true )
          {
            tmp = a;
            return false;
          }
          if ( isOnEdge( point, r, a ) == true )
          {
            if ( (sign( det( point, r, tmp ) ) == sign( det( point, r, b ) )) &&
              (sign( det( point, r, tmp ) ) != 0) )
              return false;
            else
              return true;
          }
        }
    }
    return false;
  }
  
    // Checks if z point lie on |xy| line segment
  private static boolean isOnEdge( PVector x, PVector y, PVector z )
  {

    if ( det( x, y, z ) != 0 )
    {
      return false;
    } else
    {
      if ( (min( x.x, y.x ) <= z.x) && (z.x <= max( x.x, y.x )) && (min( x.y, y.y ) <= z.y) && (z.y <= max( x.y, y.y )) )
      {
        return true;
      } else
      {
        return false;
      }
    }
  }
  
  // Determinant of the matrix
  private static float det( PVector x, PVector y, PVector z )
  {
    return (x.x*y.y + y.x*z.y + z.x*x.y - z.x*y.y - x.x*z.y - y.x*x.y);
  }
  
  // ------------ SUPPORT FUNCTIONS ------------
  private static int sign( double a )
  {
    if ( a == 0 )
      return 0;
    if ( a < 0 )
      return -1;
    return 1;
  }
  // -------------------------------------------
}