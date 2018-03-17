// Tytuł projektu + autorzy

Level level;
Player player;
GUI gui;

class GameEngine
{  
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

  GameEngine()
  {
    level = new Level();
    player = new Player();
    gui = new GUI();
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