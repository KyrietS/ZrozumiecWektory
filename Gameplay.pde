class Gameplay implements Scene
{
  String levelID;
  
  // --------------------- PRZYCISKI -------------------------------------------------------------------- //
  private Button menuButton = new Button( "home","  MENU", m2p(0.5), m2p(0.4), m2p(6.5), m2p(3.2), #c1d9ff);
  private Button helpButton = new Button( "help","  POMOC", m2p(91), m2p(0.4), m2p(8), m2p(3.2), #c1d9ff);
  private Button skipButton = new Button( "skip", "  POMIŃ", m2p(83), m2p(0.4), m2p(7), m2p(3.2), #c1d9ff );
  private Button startButton = new Button( "start", " Rozpocznij", m2p(40), m2p(80), m2p(21.5), m2p(8), #FFFFFF );
  private Button backButton = new Button( "levels", "   Powrót", m2p(5), m2p(93), m2p(12), m2p(4.5), #FFFFFF ); 
  private Button restartButton = new Button( "restart", " RESTART", m2p(7.8), m2p(0.4), m2p(7.5), m2p(3.2), #c1d9ff);
  private Button changeLevelButton = new Button( "levels", "Następny poziom", m2p(35), m2p(80), m2p(30), m2p(8), #c1d9ff );
  private Button restartLevelButton = new Button( "restart", "      Restart", m2p(35), m2p(80), m2p(30), m2p(8), #c1d9ff );
  private Button collisionTextBox = new Button("", "  KOLIZJA", m2p(60), m2p(0.4), m2p(8), m2p(3.2), #FF0000);
  // ---------------------------------------------------------------------------------------------------- //
  
  private Frame currentFrame = Frame.INTRO;          // Jakie informacje mają być wyświetlane na ekranie.
  private boolean helpActive = false;               // Czy otwarte jest okienko ze statystykami.
  private boolean timerActive = false;               // Czy licznik odlicza czas, czy stoi.
  private float startTime = 0;                       // Czas początkowy odliczania.
  private float stopTime = 0;                        // Czas końcowy odliczania.
  private boolean isSaved = false;                   // Czy stan gry został zapisany (po wygranej, aby nie zapisywać go co klatkę).
  Script script = new Script();                      // Obiekt obsługujący skrypty na poszczególnych poziomach.
  
  Gameplay( String levelID )
  {
    this.levelID = levelID;
    level = new Level( "data/levels/" + this.levelID + ".json" );
    
    player = new Player();
    collisionTextBox.setFontColor(255,255);
    collisionTextBox.isBold = true;
    collisionTextBox.isActive = false;
  }
  
// -----------------------------------------------------------------
// Wyświetlanie pojedynczej klatki gry
// -----------------------------------------------------------------
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

  public int getTime()
  {
    return (int)(stopTime - startTime);
  }

// -----------------------------------------------------------------
// Wyświetlanie wstępu do poziomu
// -----------------------------------------------------------------
  private void showIntro()
  {
    isSaved = false;
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
        case "levels": throw new ButtonEvent("levels");
      }
    }
    
  }
  
// -----------------------------------------------------------------
// Wyświetlanie klatki właściwej rozgrywki
// -----------------------------------------------------------------
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
      script.runGameplayScript( levelID, this );
      player.show();
      
      if( helpActive ) 
      {
        helpButton.col = #3884ff;
        showHelp();
      }
      else if( currentFrame != Frame.WIN && startTime == 0 )
      {
        helpButton.col = #c1d9ff;
      }
        
      showInfoBar();
    }
    catch( ButtonEvent e )
    {
      switch( e.getMessage() )
      {
        case "help": helpActive = !helpActive; break;
        default: throw e;
      }
    }
  }

// -----------------------------------------------------------------
// Wyświetlanie informacji o wystąpieniu kolizji
// -----------------------------------------------------------------
boolean _pulseActivated = false;
  private void showCollision()
  {
    collisionTextBox.show();
    if( _pulseActivated == false )
    {
      player.setPulse( #FF0000, 500 );
      _pulseActivated = true;
    }
  }
  
// -----------------------------------------------------------------
// Wyświetlanie podsumowania poziomu
// -----------------------------------------------------------------
  private int winFrameOpacity = 0;
  
  private void showWin()
  {
    helpButton.isActive = false;
    skipButton.isActive = false;
    helpButton.col = #478eff;
    skipButton.col = #478eff;
    if( _pulseActivated == false )
    {
      player.setPulse( #29A500, 500 );
      _pulseActivated = true;
    }
    fill( #42f4b0, winFrameOpacity );
    rect( 0, m2p(4), height, height );
    
    if( winFrameOpacity < 235 )
      winFrameOpacity += 255/(2.2*frameRate);
    else
    {
      if( ActiveKey.R )
        engine.startLevel( levelID );
      
      textFont( bloggerSansBold );
      textSize( m2p( 5 ) );
      fill( 0 );
      text( "Podsumowanie:", m2p(5), m2p(15) );
      textFont( bloggerSans );
      textSize( m2p( 4 ) );
      String summary = new String();
      summary += "Nazwa poziomu: \n  " + level.settings.name.replace("\n", "") + "\n";
      summary += "Czas ruchu: " + (float)getTime()/1000 + " s\n";
      summary += "Wciśniętych spacji: " + player.spaceHitCounter;
      text( summary, m2p(5), m2p(20) );
      
      boolean isWin = script.runWinScript( levelID, this );
      if( isWin )
      {
        changeLevelButton.show();
        unlockNextLevel();
      }
      else
      {
        try
        { 
          restartLevelButton.show(); 
        }
        catch( ButtonEvent e )
        {
          if( e.buttonID == "restart" )
            engine.startLevel( levelID );
        }
      }
    }
  }
  
// -----------------------------------------------------------------
// Odczytanie i reagowanie na zdarzenia z klawiatury
// -----------------------------------------------------------------
  private void readKeys()
  {
    float precision = 3.0 * 60 / frameRate;

    if( ActiveKey.SHIFT )
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
        helpActive = false;
        helpButton.isActive = false;
        helpButton.col = #478eff;
      }
    }
    if( ActiveKey.R )
      engine.startLevel( levelID );
  }
  
// -----------------------------------------------------------------
// Zapisanie stanu gry po wygranej (odblokowanie nowego poziomu)
// -----------------------------------------------------------------
  void unlockNextLevel()
  {
    if( isSaved == false )
    {
      try
      {
        isSaved = true;
        int levelNumber = Integer.parseInt( levelID.substring( levelID.length() - 2, levelID.length() ) );
        if( engine.settings.getLevelUnlocked() == levelNumber )
          engine.settings.setLevelUnlocked( engine.settings.getLevelUnlocked() + 1 );
      }
      catch( Exception e )
      {
        println("Błąd przy zapisie stanu gry!");
      }
    }
  }
  
// -----------------------------------------------------------------
// Wyświetlanie paska z informacjami
// -----------------------------------------------------------------
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
    helpButton.show();
    try{ restartButton.show(); skipButton.show(); }
    catch( ButtonEvent e )
    {
      if( e.buttonID == "restart" )
        engine.startLevel( levelID );
      if( e.buttonID == "skip" )
      {
        unlockNextLevel();
        throw new ButtonEvent("levels");
      }
    }

  }
  
// -----------------------------------------------------------------
// Zatrzymanie licznika
// -----------------------------------------------------------------
  private void stopTimer()
  {
    if( timerActive == true )
    {
      timerActive = false;
      stopTime = millis();
    }
  }
  
  void showHelp()
  {
    float helpFontSize = m2p( 2 );
    fill( color(#218cff, 245) );
    rect( m2p(55), m2p(4), m2p(45), m2p(50) );
    fill( 0 );
    textFont( bloggerSansBold );
    textSize( helpFontSize );
    text( "Obowiązujące wektory:", m2p( 56 ), m2p( 7 ) );
    textFont( bloggerSans );
    textSize( helpFontSize );
    String verticalVectorType = "";
    String horizontalVectorType = "";
    String verticalUnit = "";
    String horizontalUnit = "";
    switch( player.settings.verticalVectorType )
    {
      case DISPLACEMENT:  verticalVectorType = "wektor przemieszczenia"; verticalUnit = "m"; break;
      case VELOCITY: verticalVectorType = "wektor prędkości"; verticalUnit = "m/s"; break;
      case ACCELERATION: verticalVectorType = "wektor przyspieszenia"; verticalUnit = "m/s²"; break;
    }
    switch( player.settings.horizontalVectorType )
    {
      case DISPLACEMENT:  horizontalVectorType = "wektor przemieszczenia"; horizontalUnit = "m"; break;
      case VELOCITY: horizontalVectorType = "wektor prędkości"; horizontalUnit = "m/s"; break;
      case ACCELERATION: horizontalVectorType = "wektor przyspieszenia"; horizontalUnit = "m/s²"; break;
    }
    if( player.settings.verticalVectorMax == 0 )
      horizontalVectorType = "brak";
    if( player.settings.horizontalVectorMax == 0 )
      verticalVectorType = "brak";
    
    text("W pionie: " + verticalVectorType + "\nW poziomie: " + horizontalVectorType, m2p(57), m2p(10) );
    
    String timeLimit = "brak";
    String spacesLimit = "brak";
    if( level.settings.timeLimit > 0 )
      timeLimit = Integer.toString( level.settings.timeLimit ) + " ms";
    if( level.settings.spacesLimit > 0 )
      spacesLimit = Integer.toString( level.settings.spacesLimit );
    textFont( bloggerSansBold );
    textSize( helpFontSize );
    text( "Obowiązujące limity:", m2p( 56 ), m2p( 16 ) );
    textFont( bloggerSans );
    textSize( helpFontSize );
    text( "Wektor pionowy (max): " + p2m( level.settings.verticalVectorMax ) + " " + verticalUnit + 
        "\nWektor poziomy (max): " + p2m( level.settings.horizontalVectorMax ) + " " + horizontalUnit + 
        "\nWektor pionowy (min): " + p2m( level.settings.verticalVectorMin ) + " " + verticalUnit +
        "\nWektor poziomy (min): " + p2m( level.settings.horizontalVectorMin ) + " " + horizontalUnit +
        "\nLimit czasu: " + timeLimit +
        "\nLimit naciśnięć spacji: " + spacesLimit, m2p(57), m2p(18.5) );
    textFont( bloggerSansBold );
    textSize( helpFontSize );
    text( "Sterowanie:", m2p(56), m2p(35) );
    textFont( bloggerSans );
    textSize( helpFontSize );
    text( "Zmiana wektorów: [W][A][S][D] lub [←][↑][→][↓]" + 
        "\nZatwierdzenie zmiany: [SPACJA]" + 
        "\nZwiększenie precyzji: przytrzymaj [SHIFT]" +
        "\nRestart poziomu: [R]" + "\nPominięcie poziomu: kliknij [POMIŃ]" + 
        "\nWyjście z gry: [ESC]", m2p(57), m2p(37.5) );
  }
}

// -----------------------------------------------------------------
// Elementy aktualnie wyświetlane w oknie rozgrywki
// -----------------------------------------------------------------
public enum Frame 
{ 
  INTRO, GAMEPLAY, COLLISION, WIN; 
}
