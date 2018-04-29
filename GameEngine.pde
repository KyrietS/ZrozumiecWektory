/**********************************************************/
/*          Z R O Z U M I E Ć   W E K T O R Y             */
/* Projekt na kurs "Fizyka dla informatyków".             */
/* Realizowany przez studentów  informatyki,              */
/* na Wydziale Podstawowych Problemów Techniki,           */
/* na Politechnice Wrocławskiej.                          */
/* Skład zespołu: Sebastian Fojcik, Bartosz Stajnowski,   */
/* Piotr Andrzejewski, Mateusz Trzeciak.                  */
/* Dozwolone jest wprowadzanie własnych zmian.            */
/* Program należy zawsze rozpowszechniać wraz z kodem     */
/* źródłowym, z poszanowaniem autorów utworu pierwotnego. */
/*                                                        */
/* Projekt powstał dzięki narzędziom udostępnionym przez  */
/* Processing: https://processing.org                     */
/**********************************************************/

Level level;                            // Instancja aktualnie wczytanego poziomu.
Player player;                          // Instancja aktualnie wyświetlanego gracza.

PFont bloggerSans;                      // Czcionka BloggerSans
PFont bloggerSansBold;                  // Czcionka BloggerSans-Bold
PFont bloggerSansLightItalic;           // Czcionka BloggerSans-LightItalic (do tytułu w menu głównym)

int cursor = ARROW;                     // Rodzaj kursora

// -----------------------------------------------------------------
// Klasa spajająca i nadzorująca pracę całego programu.
// Wczytuje ustawienia gry 'settings.json' oraz zarządza
// przełączaniem scen wewnątrz gry.
// -----------------------------------------------------------------
class GameEngine
{  
  
  public Settings settings;                // Ustawienia wczytane z pliku 'settings.json'.
  Scene scene;                             // Aktualnie wyświetlana na ekranie scena.
  
  // -----------------------------------------------------------------
  // Aktualizacja okna
  // -----------------------------------------------------------------
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

  // -----------------------------------------------------------------
  // Konstruktor ładujący zasoby przy starcie programu.
  // -----------------------------------------------------------------
  GameEngine()
  {
    settings = new Settings("data/settings.json");
    scene = new HomeScene();
    
    bloggerSans = createFont("data/fonts/BloggerSans.ttf", 12);
    bloggerSansBold = createFont("data/fonts/BloggerSans-Bold.ttf", 12);
    bloggerSansLightItalic = createFont("data/fonts/BloggerSans-LightItalic.ttf", 80);
    
    textFont( bloggerSans );
  }

  // -----------------------------------------------------------------
  // Załadowanie wybranego poziomu.
  // -----------------------------------------------------------------
  public void startLevel( String levelID )
  {
    scene = new Gameplay( levelID );
  }

  // ------------------------ SETTINGS ----------------------------------
  // Przechowuje globalne ustawienia programu wczytane z 'settings.json'
  // --------------------------------------------------------------------
  public class Settings
  {
    private int levelUnlocked = 99;                  // Ile poziomów jest odblokowanych (minimum 1)
    private boolean developerMode = false;           // Tryb deweloperski (odblokowane wszystkie poziomu + debug info)
    private color ballColor = #FFF600;               // Kolor wypełnienia piłeczki sterowanej przez gracza.
    
    private String settingsPath;                     // Ścieżka do ustawień. Standardowo: "data/settings.json"

    // -----------------------------------------------------------------
    // Załadowanie ustawień
    // -----------------------------------------------------------------
    Settings( String settingsPath )
    {
      this.settingsPath = settingsPath;
      loadSettings( settingsPath );
    }
    
    // ------------- Gettery ----------------------
    public int getLevelUnlocked(){ return levelUnlocked; }
    public boolean getDeveloperMode(){ return developerMode; }
    public color getBallColor(){   return ballColor;   }
    
    // -----------------------------------------------------------------
    // Settery, które automatycznie zapisują zmianę do pliku.
    // -----------------------------------------------------------------
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
    
    // -----------------------------------------------------------------
    // Zapisanie ustawień do pliku 'settingsPath'.
    // -----------------------------------------------------------------
    private void saveToFile()
    {
      JSONObject settings = new JSONObject();
      settings.setInt("level-unlocked", levelUnlocked);
      settings.setBoolean("developer-mode", developerMode);
      settings.setString("hero-picture", hex( ballColor ) );
      saveJSONObject( settings, settingsPath );
    }    
    
    // -----------------------------------------------------------------
    // Wczytanie ustawień z pliku 'settingsPath'.
    // -----------------------------------------------------------------
    private void loadSettings( String settingsPath )
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
