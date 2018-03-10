
class GameEngine
{
  private final Level level = new Level();
  private Player player = new Player( level.settings );
  public void update()
  {
    readKeys();
    player.move();
    player.show();
  }

  GameEngine()
  {
    
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