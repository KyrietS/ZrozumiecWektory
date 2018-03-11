class GameEngine
{
  private final Level level = new Level();
  private final Player player = new Player( level );
  public void update()
  {
    readKeys();
    try{ player.move(); }
    catch( HitWallException e ) {}
    catch( HitFinishException e ) {}
    player.show();
    level.show();
  }

  private void readKeys()
  {
    float precision = 3.0;

    if( ActiveKey.D )
      player.addHorizontal( precision );
    if( ActiveKey.A )
      player.addHorizontal( -precision );
    if( ActiveKey.W )
      player.addVertical( -precision );
    if( ActiveKey.S )
      player.addVertical( precision );
    if( ActiveKey.SPACE )
    {
      player.changeVectors();
      ActiveKey.SPACE = false; // Aby wciśnięcie było jednokrotne
    }
  }
  
  
  
}