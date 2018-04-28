interface Scene
{
  void update();
}

class HomeScene implements Scene
{
  Button levelsButton;
  Button changeSkinButton;
  Button aboutButton;
  Button exitButton;
  
  HomeScene()
  {
    levelsButton = new Button("levels", "        Graj", m2p(32.5), m2p(40), m2p(36), m2p(10), #26ad96);
    changeSkinButton = new Button("change-skin", " Wybierz postać", m2p(32.5), m2p(50), m2p(36), m2p(10), #26ad96);
    aboutButton = new Button("about", "   O projekcie", m2p(32.5), m2p(60), m2p(36), m2p(10), #26ad96);
    exitButton = new Button("exit", "      Wyjście", m2p(32.5), m2p(70), m2p(36), m2p(10), #26ad96);
  }
  
  void update()
  {
    fill(#dbffe6 );
    rect( 0, 0, m2p(100), m2p(100) );
    
    textFont( bloggerSansLightItalic );
    textSize( m2p(12) );
    fill( 0 );
    text("Zrozumieć Wektory", m2p(4), m2p( 20 ) );
    
    levelsButton.show();
    changeSkinButton.show();
    aboutButton.show();
    exitButton.show();
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
        
        if( i+1 <= engine.settings.levelUnlocked || engine.settings.getDeveloperMode() == true )
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

class AboutScene implements Scene
{
  private Button backButton = new Button( "home", "Powrót do MENU", m2p(5), m2p(91), m2p(16.8), m2p(4.5), #FFFFFF );
  public void update()
  {
    fill(255 );
    rect( 0, 0, m2p(100), m2p(100) );
    fill( 0 );
    textFont( bloggerSans );
    textSize( m2p( 6.2 ) );
    text("Zrozumieć Wektory", m2p(2.5), m2p( 15 ) );
    textSize( m2p( 3 ) );
    text("Projekt powstał w ramach kursu:\n„Fizyka dla informatyków — czyli od prostoty do złożoności”\n\n" + 
         "Skład zespołu:\n  Sebastian Fojcik\n  Bartosz Stajnowski\n  Piotr Andrzejewski\n  Mateusz Trzeciak", m2p( 3 ), m2p( 27 ) );
    //text("„Fizyka dla informatyków — czyli od prostoty do złożoności”", m2p( 2.7 ), m2p( 33 ) );
    textSize( m2p(5) );
    //text("Wydział Podstawowych Problemów Techniki", m2p( 5 ), m2p( 68 ) );
    
    image( wpptLogo, m2p(55), m2p(2), m2p(20), m2p(20) );
    image( kiLogo, m2p(77), m2p(2), m2p(20), m2p(20) );
    image( pwrLogo, m2p(40), m2p(60), m2p(20), m2p(29.04) );
    backButton.show();
  }
}
