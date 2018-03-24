class Gameplay implements Scene
{
  String levelID;
  Button menuButton = new Button( "home","  MENU", 0.5, 0.4, 6.5, 3.2, #c1d9ff);
  Button statsButton = new Button( "stats","  STATYSTYKI", 88, 0.4, 10.5, 3.2, #c1d9ff);
  
  boolean statsActive = false;
  boolean timerActive = false;
  float startTime = 0;
  float stopTime = 0;
  
  Gameplay( String levelID )
  {
    this.levelID = levelID;
    level = new Level( "data/levels/" + this.levelID + ".json" );
    player = new Player();
  }
  
  void update()
  {
    try
    {
      readKeys();
      try{ player.move(); player.fillColor = #FFF600; } // TYMCZASOWE
      catch( HitWallException e ) 
      {
        player.fillColor = #c19e20;
        if( timerActive == true )
        {
          timerActive = false;
          stopTime = millis();
        }
      }
      catch( HitFinishException e )
      {
        level.finish.col = #FF0000;
      }
      level.show();
      player.show();
      if( statsActive ) showStats();
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
      
      if( timerActive == false && startTime == 0 )
      {
        timerActive = true;
        startTime = millis();
      }
    }
  }
  
  void showInfoBar()
  {
    fill( #77abff );
    rect( 0,0, m2p( mapSize ), m2p(4) );
    textFont( bloggerSans );
    
    // ----- LICZNIK CZASU ------ //
    float time;
    if( timerActive == false && stopTime != 0 )
      time = stopTime - startTime;
    else
      time = millis() - startTime;
    textSize( m2p(4) );
    fill( 0 );
    int minutes = (int)(time / 60000);
    int seconds = (int)(time / 1000 ) - 60 * minutes;
    int milliseconds = (int)(time) - 1000*seconds - 60000 * minutes;
    String timeText = minutes < 10 ? "0" + minutes : "" + minutes;
    timeText += ":" + (seconds < 10 ? "0" + seconds : "" + seconds);
    timeText += "." + (milliseconds < 100 ? (milliseconds < 10 ? "00" + milliseconds : "0" + milliseconds) : milliseconds);
    
    if( timerActive == true || startTime != 0 )
      text( timeText, m2p(42), m2p(3.6) );
    else
      text( "00:00.000", m2p(42), m2p(3.6) );

    // ---- PRZYCISKI ---- //
    menuButton.show();
    statsButton.show();

  }
  
  void showStats()
  {
    fill( #218cff );
    rect( m2p(80), m2p(4), m2p(20), m2p(50) );
  }
}