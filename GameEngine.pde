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
    
    public getLevelUnlocked(){ return levelUnlocked; }
    public getDeveloperMode(){ return developerMode; }
    public getHeroPicture(){   return heroPicture;   }
    
    public setLevelUnlocked( int n )
    {
      levelUnlocked = n;
      saveToFile();
    }
    public setDeveloperMode( boolean b )
    {
      developerMode = b;
      saveToFIle();
    }
    public setHeroPicture( String s )
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
    
    private void loadLevel( settingsPath )
    {
      JSONObject settings;
      try
      {
        settings = loadJSONObject( settingsPath );
      }
      catch( Exception e )
      {
        println("Błąd przy odczytywaniu ustawień: " + stringPath);
      }
      
      levelUnlocked = settings.getInt("level-unlocked");
      developerMode = settings.getBoolean("developer-mode");
      heroPicture   = settings.getString("hero-picture");
    }
  }
}