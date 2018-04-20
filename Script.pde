

public class Script
{
  color successColor = #3f88ff;
  color warningColor = #c1a100;
  color failColor    = #f44842;
  
  public void runGameplayScript( String levelID )
  {
   
  }
  
  public boolean runWinScript( String levelID, Gameplay gameplay )
  {
    switch( levelID )
    {
      case "level02": return level02WinScript( gameplay );
      case "level03": return level03WinScript();
      default:        return defaultWinScript( gameplay );
    }
  }
  
  private boolean defaultWinScript(Gameplay gameplay )
  {
    if( level.settings.timeLimit == 0 || gameplay.getTime() <= level.settings.timeLimit )
    {
      fill( successColor );
      text("Gratulacje!", m2p(5), m2p(50) );
      return true;
    }
    else
    {
      fill( failColor );
      text("Przekroczono limit czasu, który wynosi: " + level.settings.timeLimit + " ms", m2p(5), m2p(50) );
      return false;
    }
    
  }
  
  private boolean level02WinScript( Gameplay gameplay )
  {
    if( gameplay.getTime() < 900 || gameplay.getTime() > 1100 )
    {
      fill( failColor );
      text("Piłeczka nie dotarła do mety w wyznaczonym czasie", m2p(5), m2p(50) );
      return false;
    }
    else if( gameplay.getTime() >= 900 && gameplay.getTime() <= 970 )
    {
      fill( warningColor );
      text("Twój czas wyniósł trochę mniej niż sekunda.\nZastanów się dlaczego? O czym zapomniałeś przy\nustalaniu wektora? :-)", m2p(5), m2p(50) );
      return true;
    }
    else
      return defaultWinScript( gameplay );
  }
  private boolean level03WinScript()
  {
    fill(successColor);
    text("Podstawy działania gry już znasz.\nNdszedł czas, by Zrozumieć Wektory!", m2p(5), m2p(50) );
    return true;
  }
}
