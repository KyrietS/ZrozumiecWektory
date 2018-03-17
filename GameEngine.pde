// Tytuł projektu + autorzy

class GameEngine
{
  private final Level level = new Level();
  private final Player player = new Player( level );
  private final GUI gui = new GUI();
  
  public void update()
  {
    readKeys();
    try{ player.move(); player.fillColor = #FFF600; } // TYMCZASOWE
    catch( HitWallException e ) { player.fillColor = #c19e20; } // TYMCZASOWE
    catch( HitFinishException e ) {}
    level.show();
    player.show();
    
    gui.infoBar();
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