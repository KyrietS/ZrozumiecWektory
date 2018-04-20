interface Scene
{
  void update();
}

class HomeScene implements Scene
{
  Button playButton;
  Button levelsButton;
  HomeScene()
  {
    playButton = new Button("play", "Zagraj", m2p(40), m2p(40), m2p(20), m2p(10), #26ad96 );
    levelsButton = new Button("levels", "Wybierz poziom", m2p(40), m2p(55), m2p(40), m2p(10), #26ad96);
  }
  
  void update()
  {
    fill(#dbffe6 );
    rect( 0, 0, m2p(100), m2p(100) );
    playButton.show();
    levelsButton.show();
  }
}

class LevelsScene implements Scene
{
  private Button[] levels = new Button[ 18 ];
  private Button backButton = new Button( "home", "Powrót do MENU", m2p(5), m2p(91), m2p(16.8), m2p(4.5), #FFFFFF );
  
  LevelsScene()
  {
    for( int i = 0; i < levels.length; i++ )
    {
      Button levelButton;
      try
      {
        Level level;
        String levelID;
        if( i+1 < 10 )
        {
          level = new Level("data/levels/level0" + (i+1) + ".json");
          levelID = "level0" + (i+1);
        }
        else
        {
          level = new Level("data/levels/level" + (i+1) + ".json");
          levelID = "level" + (i+1);
        }
        String levelName = level.settings.name.replace("\n", "");
        
        if( i+1 <= engine.settings.levelUnlocked )
          levelButton = new Button(levelID, levelName, m2p(5), (int)m2p(10) + i*(int)m2p(4.4), m2p(90), m2p(4), #26ad96 );
        else
        {
          levelButton = new Button("", levelName, m2p(5), (int)m2p(10) + i*(int)m2p(4.4), m2p(90), m2p(4), #c4c4c4 );
          levelButton.isActive = false;
        }
      }
      catch( Exception e)
      {
        levelButton = new Button("", "", m2p(5), (int)m2p(10) + i*(int)m2p(4.4), m2p(90), m2p(4), #c4c4c4 );
        levelButton.isActive = false;
      }

      levels[ i ] = levelButton;
    }
  }
  
  void update()
  {
    fill(#dbffe6 );
    rect( 0, 0, m2p(100), m2p(100) );
    
    showTitle();
    
    for( int i = 0; i < levels.length; i++ )
    {
      try
      {
        levels[ i ].show();
      }
      catch( ButtonEvent e )
      {
        engine.startLevel( e.buttonID );
      }
    }
    
    backButton.show();
  }
  
  private void showTitle()
  {
    fill( 0 );
    textFont( bloggerSansBold );
    textSize( m2p( 6 ) );
    text( "Wybierz poziom", m2p(5), m2p(7.5) );
  }
}
