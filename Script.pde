

public class Script
{
  color successColor = #3f88ff;
  color warningColor = #c1a100;
  color failColor    = #f44842;
  public void runGameplayScript( String levelID )
  {
   
  }
  
  public void runWinScript( String levelID, Gameplay gameplay )
  {
    switch( levelID )
    {
      case "level02": level02WinScript( gameplay ); break;
      case "level03": level03WinScript(); break;
      default: defaultWinScript(); break;
    }
  }
  
  private void defaultWinScript()
  {
    fill( successColor );
    text("Gratulacje!", m2p(5), m2p(50) );
  }
  
  private void level02WinScript( Gameplay gameplay )
  {
    if( gameplay.getTime() < 900 || gameplay.getTime() > 1100 )
    {
      fill( failColor );
      text("Piłeczka nie dotarła do mety w wyznaczonym czasie", m2p(5), m2p(50) );
      if( engine.settings.levelUnlocked == 3 )
        engine.settings.setLevelUnlocked( 2 );
    }
    else if( gameplay.getTime() >= 900 && gameplay.getTime() <= 970 )
    {
      fill( warningColor );
      text("Twój czas wyniósł trochę mniej niż sekunda.\nZastanów się dlaczego? O czym zapomniałeś przy\nustalaniu wektora? :-)", m2p(5), m2p(50) );
    }
    else
      defaultWinScript();
  }
  private void level03WinScript()
  {
    fill(successColor);
    text("Podstawy działania gry już znasz.\nNdszedł czas, by Zrozumieć Wektory!", m2p(5), m2p(50) );
  }
}
