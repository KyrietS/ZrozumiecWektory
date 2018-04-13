class Gameplay implements Scene
{
  String levelID;
  Button menuButton = new Button( "home","  MENU", 0.5, 0.4, 6.5, 3.2, #c1d9ff);
  Button statsButton = new Button( "stats","  STATYSTYKI", 88, 0.4, 10.5, 3.2, #c1d9ff);
  Button startButton = new Button( "start", " Rozpocznij", 40, 80, 21.5, 8, #FFFFFF );
  Button backButton = new Button( "back", "Powrót do MENU", 5, 95, 12, 3, #FFFFFF ); 
  Button restartButton = new Button( "play", " RESTART", 7.8, 0.4, 7.5, 3.2, #c1d9ff);
  Button changeLevelButton = new Button( "levels", "Następny poziom", 40, 80, 30, 8, #c1d9ff );
  private Button collisionTextBox = new Button("", "  KOLIZJA", 60, 0.4, 8, 3.2, #FF0000);
  
  boolean statsActive = false;
  boolean timerActive = false;
  Frame currentFrame = Frame.INTRO;
  float startTime = 0;
  float stopTime = 0;
  
  Gameplay( String levelID )
  {
    this.levelID = levelID;
    level = new Level( "data/levels/" + this.levelID + ".json" );
    player = new Player();
    
    collisionTextBox.setFontColor(255,255);
    collisionTextBox.isBold = true;
    collisionTextBox.isActive = false;
  }
  
  void update()
  {
    switch( currentFrame )
    {
      case INTRO: showIntro(); break;
      case GAMEPLAY: readKeys(); showGameplay(); break;
      case COLLISION: showGameplay(); showCollision(); break;
      case WIN: showGameplay(); showWin(); break;
    }
    
    
  }
  
  private void showIntro()
  {
    fill(#42f4b0);
    rect( 0, 0, height, height );
    textFont( bloggerSansBold );
    textSize( m2p( 5 ) );
    fill( 0 );
    text( level.settings.name, m2p(5), m2p(10) );
    textFont( bloggerSans );
    textSize( m2p( 4 ) );
    text( level.settings.description, m2p(5), m2p(16) );
    
    try
    {
      startButton.show();
      backButton.show();
    }
    catch( ButtonEvent e )
    {
      switch( e.buttonID )
      {
        case "start": currentFrame = Frame.GAMEPLAY; break;
        case "back": throw new ButtonEvent("home");
      }
    }
    
  }
  
  private void showGameplay()
  {
    try
    {
      try
      { 
        player.move();
      }
      catch( HitWallException e ) 
      {
        currentFrame = Frame.COLLISION;
        stopTimer();
      }
      catch( HitFinishException e )
      {
        currentFrame = Frame.WIN;
        stopTimer();
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
  
  private void showCollision()
  {
    collisionTextBox.show();
    player.setPulse( #FF0000, 500 );
  }
  
  private int winFrameOpacity = 0;
  private void showWin()
  {
    statsButton.isActive = false;
    player.setPulse( #29A500, 500 );
    fill( #42f4b0, winFrameOpacity );
    rect( 0, m2p(4), height, height );
    
    if( winFrameOpacity < 235 )
      winFrameOpacity += 255/(2.5*frameRate);
    else
    {
      textFont( bloggerSansBold );
      textSize( m2p( 5 ) );
      fill( 0 );
      text( "Podsumowanie:", m2p(5), m2p(10) );
      textFont( bloggerSans );
      textSize( m2p( 4 ) );
      String summary = new String();
      summary += "Nazwa poziomu: " + level.settings.name + "\n";
      summary += "Całkowita droga: " + "\n";
      summary += "Czas ruchu: " + (stopTime - startTime)/1000 + " s\n";
      summary += "Prędkość średnia: " + "\n";
      summary += "Wciśniętych spacji: " + player.spaceHitCounter + "\n\n";
      summary += "Gratulacje!";
      text( summary, m2p(5), m2p(16) );
      try{ changeLevelButton.show(); }
      catch( ButtonEvent e )
      {
        throw new ButtonEvent("home");
      }
    }
  }
  
  private void readKeys()
  {
    float precision = 3.0 * 60 / frameRate;

    if( ActiveKey.CTRL )
      precision = precision / 15;

    if( ActiveKey.D || ActiveKey.RIGHT )
      player.addHorizontal( precision );
    if( ActiveKey.A || ActiveKey.LEFT )
      player.addHorizontal( -precision );
    if( ActiveKey.W || ActiveKey.UP )
      player.addVertical( -precision );
    if( ActiveKey.S || ActiveKey.DOWN )
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
    restartButton.show();
    statsButton.show();

  }
  
  private void stopTimer()
  {
    if( timerActive == true )
    {
      timerActive = false;
      stopTime = millis();
    }
  }
  
  void showStats()
  {
    fill( #218cff );
    rect( m2p(80), m2p(4), m2p(20), m2p(50) );
  }
}

public enum Frame 
{ 
  INTRO, GAMEPLAY, COLLISION, FAIL, WIN; 
}