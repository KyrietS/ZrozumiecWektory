// Tytuł projektu + autorzy

Level level;
Player player;

PFont bloggerSans;
PFont bloggerSansBold;
PFont bloggerSansLightItalic;

int cursor = ARROW;

class GameEngine
{  
  
  public Settings settings;
  Scene scene;
  
  public void update()
  {
    cursor = ARROW;
    try
    {
      scene.update();
    }
    catch( ButtonEvent e )
    {
      switch( e.getMessage() )
      {
        case "play": scene = new Gameplay("level01"); break;
        case "skins": scene = new SkinsScene(); break;
        case "levels": scene = new LevelsScene(); break;
        case "home": scene = new HomeScene(); break;
        case "about": scene = new AboutScene(); break;
        case "exit": exit(); break;
      }
    }
    cursor( cursor );
  }

  GameEngine()
  {
    settings = new Settings("data/settings.json");
    scene = new HomeScene();
    
    bloggerSans = createFont("data/fonts/BloggerSans.ttf", 12);
    bloggerSansBold = createFont("data/fonts/BloggerSans-Bold.ttf", 12);
    bloggerSansLightItalic = createFont("data/fonts/BloggerSans-LightItalic.ttf", 80);
    
    textFont( bloggerSans );
  }

  public void startLevel( String levelID )
  {
    scene = new Gameplay( levelID );
  }

  public class Settings
  {
    private int levelUnlocked = 99;
    private boolean developerMode = false;
    private color ballColor = #FFF600;
    
    private String settingsPath;
    
    Settings( String settingsPath )
    {
      this.settingsPath = settingsPath;
      loadLevel( settingsPath );
    }
    
    public int getLevelUnlocked(){ return levelUnlocked; }
    public boolean getDeveloperMode(){ return developerMode; }
    public color getBallColor(){   return ballColor;   }
    
    public void setLevelUnlocked( int n )
    {
      levelUnlocked = n;
      saveToFile();
    }
    public void setDeveloperMode( boolean b )
    {
      developerMode = b;
      saveToFile();
    }
    public void setBallColor( color s )
    {
      ballColor = s;
      saveToFile();
    }
    
    private void saveToFile()
    {
      JSONObject settings = new JSONObject();
      settings.setInt("level-unlocked", levelUnlocked);
      settings.setBoolean("developer-mode", developerMode);
      settings.setString("hero-picture", hex( ballColor ) );
      saveJSONObject( settings, settingsPath );
    }    
    
    private void loadLevel( String settingsPath )
    {
      try
      {
        JSONObject settings = loadJSONObject( settingsPath );
        levelUnlocked = settings.getInt("level-unlocked");
        developerMode = settings.getBoolean("developer-mode");
        ballColor   = color( unhex( settings.getString("hero-picture") ) );
      }
      catch( Exception e )
      {
        println("Błąd przy odczytywaniu ustawień: " + settingsPath);
      }
    } // loadLevel
  } // Settings
} // GameEngine
