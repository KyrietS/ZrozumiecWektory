interface Scene
{
  void update();
}

class HomeScene implements Scene
{
  Button levelsButton = new Button("levels", "        Graj", m2p(32.5), m2p(35), m2p(36), m2p(10), #e88140);
  Button changeSkinButton = new Button("skins", "   Zmień kolor", m2p(32.5), m2p(45), m2p(36), m2p(10), #e88140);
  Button aboutButton = new Button("about", "    O projekcie", m2p(32.5), m2p(55), m2p(36), m2p(10), #e88140);
  Button exitButton = new Button("exit", "      Wyjście", m2p(32.5), m2p(65), m2p(36), m2p(10), #e88140);
  
  ImageLink wpptImage = new ImageLink( "http://wppt.pwr.edu.pl/", "data/images/wppt-logo.png", m2p(39), m2p(85), m2p(10), m2p(10) );
  ImageLink kiImage = new ImageLink( "http://ki.pwr.edu.pl/", "data/images/ki-wppt-logo.png", m2p(51), m2p(85), m2p(10), m2p(10) );
  
  void update()
  {
    //fill(#dbffe6 );
    fill( 255 );
    rect( 0, 0, m2p(100), m2p(100) );
    
    textFont( bloggerSansLightItalic );
    textSize( m2p(12) );
    fill(#e88140);
    rect( 0, m2p(8.8), m2p(100), m2p(15) );
    fill( 255 );
    text("Zrozumieć Wektory", m2p(4), m2p( 20 ) );
    
    levelsButton.show();
    changeSkinButton.show();
    aboutButton.show();
    exitButton.show();
    
    wpptImage.show();
    kiImage.show();
  }
  
}

class SkinsScene implements Scene
{
  private Button backButton = new Button( "home", "Powrót do MENU", m2p(5), m2p(91), m2p(16.8), m2p(4.5), #FFFFFF );
  
  color currentColor;
  
  Skin skins[] = {new Skin(#FFF600), new Skin(#238E23), new Skin(#6699FF), new Skin(#FF00FF), new Skin(#FF3366), new Skin(#CC99CC), new Skin(#0099CC), new Skin(#00FFFF), new Skin(#00FF99), new Skin(#CCFFCC), 
                  new Skin(#00FF00), new Skin(#66CC00), new Skin(#CCFF66), new Skin(#CCFF00), new Skin(#999900), new Skin(#999933), new Skin(#CCCC33), new Skin(#CCCC66), new Skin(#CCCC99), new Skin(#FFFFCC),
                  new Skin(#FFCC00), new Skin(#FF9900), new Skin(#FF9966), new Skin(#CC9999), new Skin(#FFCCCC), new Skin(#FFCC99), new Skin(#FF3300), new Skin(#5F9F9F), new Skin(#4A766E), new Skin(#9932CD),
                  new Skin(#9F5F9F), new Skin(#7093DB), new Skin(#D19275), new Skin(#CD7F32), new Skin(#F5CCB0), new Skin(#DBDB70), new Skin(#ABCDEF), new Skin(#93DB70), new Skin(#70DB93), new Skin(#65BBAA),
                  new Skin(#9F9F5F), new Skin(#C0D9D9), new Skin(#A8A8A8), new Skin(#8F8FBD), new Skin(#E9C2A6), new Skin(#E47833), new Skin(#32CD99), new Skin(#EAEAAE), new Skin(#9370DB), new Skin(#DB7093),
                  new Skin(#3232CD), new Skin(#4D4DFF), new Skin(#FF6EC7), new Skin(#FF7F00), new Skin(#FF2400), new Skin(#DB70DB), new Skin(#5959AB), new Skin(#FFFFFF), new Skin(#D5D5D5), new Skin(#C0C0C0) };
  
  SkinsScene()
  {
    currentColor = engine.settings.ballColor;
  }
  
  void update()
  {
    fill(#dbffe6 );
    rect( 0, 0, m2p(100), m2p(100) );
    
    fill( 0 );
    textFont( bloggerSansBold );
    textSize( m2p( 6 ) );
    text( "Wybierz kolor piłeczki", m2p(5), m2p(15) );
    
    for( int i = 0; i < skins.length; i++ )
    {
      skins[i].show( m2p(5) + (i%10)*m2p(10), m2p(15) + m2p(10)*(i / 10 + 1) );
    }
    
    backButton.show();
  }
  
  class Skin
  {
    color col;
    Skin( color col )
    {
      this.col = col;
    }
    
    void show( float x, float y )
    {
      if( currentColor == col )
        strokeWeight( m2p(0.4) );
      else
        strokeWeight( 1 );
      fill( col );
      
      float diameter = m2p(6);
      
      if( mouseHover( x, y ) )
      {
        diameter = m2p(7);
        if( mousePressed && buttonPressed == false )
        {
          engine.settings.setBallColor( col );
          currentColor = col;
          buttonPressed = true;
        }
      }
      
      ellipse( x, y, diameter, diameter );
      strokeWeight( 1 );
    }
  }
  
  private boolean mouseHover( float x, float y )
  {
    if( sqrt( (mouseX- (width-height)/2 - x)*(mouseX- (width-height)/2 - x) + (mouseY - y)*(mouseY - y) ) <= m2p(6) )
      return true;
    else
      return false;
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
  private ImageLink pwrImage = new ImageLink( "http://pwr.edu.pl/", "data/images/pwr-logo.png", m2p(3), m2p(3), m2p(20), m2p(29.04) );
  private ImageLink wpptImage = new ImageLink( "http://wppt.pwr.edu.pl/", "data/images/wppt-logo.png", m2p(48), m2p(75), m2p(20), m2p(20) );
  private ImageLink kiImage = new ImageLink( "http://ki.pwr.edu.pl/", "data/images/ki-wppt-logo.png", m2p(74), m2p(75), m2p(20), m2p(20) );
  public void update()
  {
    fill(255 );
    rect( 0, 0, m2p(100), m2p(100) );
    fill( 0 );
    textFont( bloggerSans );
    textSize( m2p( 8 ) );
    text("Zrozumieć Wektory", m2p(31), m2p( 15 ) );
    textSize( m2p( 3 ) );
    text("Projekt powstał w ramach kursu:", m2p(43), m2p(35) );
    text("„Fizyka dla informatyków — czyli od prostoty do złożoności”\n\n", m2p( 27 ), m2p( 40 ) );
    text("Skład zespołu:\n  Sebastian Fojcik\n  Bartosz Stajnowski\n  Piotr Andrzejewski\n  Mateusz Trzeciak", m2p(3), m2p(50) );
    textSize( m2p(5) );
    
    pwrImage.show();
    wpptImage.show();
    kiImage.show();
    
    backButton.show();
  }
}
