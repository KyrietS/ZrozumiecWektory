// Tytuł projektu + autorzy

Level level;
Player player;

PFont bloggerSans;
PFont bloggerSansBold;
PFont bloggerSansLightItalic;
PImage kiLogo;
PImage wpptLogo;

class GameEngine
{  
  
  public Settings settings;
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
        case "about": scene = new AboutScene(); break;
        case "exit": exit(); break;
      }
    }
  }

  GameEngine()
  {
    settings = new Settings("data/settings.json");
    scene = new HomeScene();
    
    bloggerSans = createFont("data/fonts/BloggerSans.ttf", 12);
    bloggerSansBold = createFont("data/fonts/BloggerSans-Bold.ttf", 12);
    bloggerSansLightItalic = createFont("data/fonts/BloggerSans-LightItalic.ttf", 80);
    kiLogo = loadImage("data/images/ki-wppt-logo.png");
    wpptLogo = loadImage("data/images/wppt-logo.png");
    
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
    private String heroPicture = "default";
    
    private String settingsPath;
    
    Settings( String settingsPath )
    {
      this.settingsPath = settingsPath;
      loadLevel( settingsPath );
    }
    
    public int getLevelUnlocked(){ return levelUnlocked; }
    public boolean getDeveloperMode(){ return developerMode; }
    public String getHeroPicture(){   return heroPicture;   }
    
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
    public void setHeroPicture( String s )
    {
      heroPicture = s;
      saveToFile();
    }
    
    private void saveToFile()
    {
      JSONObject settings = new JSONObject();
      settings.setInt("level-unlocked", levelUnlocked);
      settings.setBoolean("developer-mode", developerMode);
      settings.setString("hero-picture", heroPicture);
      saveJSONObject( settings, settingsPath );
    }    
    
    private void loadLevel( String settingsPath )
    {
      try
      {
        JSONObject settings = loadJSONObject( settingsPath );
        levelUnlocked = settings.getInt("level-unlocked");
        developerMode = settings.getBoolean("developer-mode");
        heroPicture   = settings.getString("hero-picture");
      }
      catch( Exception e )
      {
        println("Błąd przy odczytywaniu ustawień: " + settingsPath);
      }
    } // loadLevel
  } // Settings
} // GameEngine
