// Tytuł projektu + autorzy

Level level;
Player player;

PFont bloggerSans;
PFont bloggerSansBold;

class GameEngine
{  
  
  Scene scene;
  
  public void update()
  {
    try
    {
      scene.update();
    }
    catch( ButtonEvent e )
    {
      switch( e.getMessage() )
      {
        case "play": scene = new Gameplay("level01"); break;
        case "levels": scene = new LevelsScene(); break;
        case "home": scene = new HomeScene(); break;
      }
    }
  }

  GameEngine()
  {
    scene = new HomeScene();
    
    bloggerSans = createFont("data/fonts/BloggerSans.ttf", 12);
    bloggerSansBold = createFont("data/fonts/BloggerSans-Bold.ttf", 12);
    textFont( bloggerSans );
  }

  public void startLevel( String levelID )
  {
    scene = new Gameplay( levelID );
  }

}