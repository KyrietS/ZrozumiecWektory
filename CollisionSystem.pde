static class CollisionSystem
{
  static public boolean isCollision( ArrayList<PVector> vertices, PVector pos, float radius )
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
  // --- PRIVATE ---
  static private float distance( PVector a, PVector b, PVector p )
  {
        float d2 = PVector.dist(a, b)*PVector.dist(a,b);
    if( d2 == 0.0 )
      return PVector.dist(p, a);
    float t = max(0, min(1, PVector.dot(PVector.sub(p,a), PVector.sub(b,a) ) / d2));
    PVector projection = PVector.add(a, (PVector.mult(PVector.sub(b,a),t ) ));
    return p.dist( projection );
  }
}