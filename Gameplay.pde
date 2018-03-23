class Gameplay implements Scene
{
  String levelID;
  Button menuButton = new Button( "home","  MENU", 0.5, 0.4, 6.5, 3.2, #c1d9ff);
  Button statsButton = new Button( "stats","  STATYSTYKI", 88, 0.4, 10.5, 3.2, #c1d9ff);
  
  boolean statsActive = false;
  
  Gameplay( String levelID )
  {
    this.levelID = levelID;
    level = new Level( "levels/" + this.levelID + ".json" );
    player = new Player();
  }
  
  void update()
  {
    try
    {
      readKeys();
      try{ player.move(); player.fillColor = #FFF600; } // TYMCZASOWE
      catch( HitWallException e ) { player.fillColor = #c19e20; } // TYMCZASOWE
      catch( HitFinishException e ) {}
      level.show();
      player.show();
      if( statsActive )
        showStats();
      showInfoBar();
    }
    catch( ButtonEvent e )
    {
      switch( e.getMessage() )
      {
        case "stats": statsActive = !statsActive; break;
        default: throw e;
      }
    }
    
    
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
  
  void showInfoBar()
  {
    fill( #77abff );
    rect( 0,0, m2p( mapSize ), m2p(4) );
    
    textFont( bloggerSans );
    menuButton.show();
    statsButton.show();
  }
  
  void showStats()
  {
    fill( #218cff );
    rect( m2p(80), m2p(4), m2p(20), m2p(50) );
  }
}