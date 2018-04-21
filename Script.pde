

public class Script
{
  color successColor = #3f88ff;
  color warningColor = #c1a100;
  color failColor    = #f44842;
  
  public void runGameplayScript( String levelID )
  {
    switch( levelID )
    {
      case "level07": level07Script(); break;
    }
  }
  
  public boolean runWinScript( String levelID, Gameplay gameplay )
  {
    switch( levelID )
    {
      case "level02": return level02WinScript( gameplay );
      case "level03": return level03WinScript();
      case "level07": return level07WinScript( gameplay );
      case "level10": return level10WinScript();
      default:        return defaultWinScript( gameplay );
    }
  }
  
  private void level07Script()
  {
    if( player.isFrozen )
      player.velocity = new PVector(0, -m2p(40) );
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
  private boolean level07WinScript( Gameplay gameplay )
  {
    if( gameplay.getTime() > 7000 )
    {
      fill( successColor );
      text("Gratulacje!\n\nVp = 40 m/s   tyle Ci wyszło?", m2p(5), m2p(50) );
      return true;
    }
    else
    {
      fill( failColor );
      text("Lot był zbyt krótki. Powinien trwać ponad 7 sekund.", m2p(5), m2p(50) );
      return false;
    }
  }
  
  private boolean level10WinScript()
  {
    if( player.spaceHitCounter == 1 )
    {
      fill( successColor );
      text("Gratulacje!\n\nRozumiesz działanie wektora przesunięcia", m2p(5), m2p(50) );
      return true;
    }
    else
    {
      // -------- Odmiana polskiego wyrazu <3 ----------
      String word1;
      String word2;
      if( player.spaceHitCounter == 2 ){ word1 = "ruchy"; word2 = "ruch"; }
      else if( player.spaceHitCounter == 3 || player.spaceHitCounter == 4){ word1 = "ruchy"; word2 = "ruchy"; }
      else if( player.spaceHitCounter == 5 ){ word1 = "ruchów"; word2 = "ruchy"; }
      else{ word1 = "ruchów"; word2 = "ruchów"; }
      // -----------------------------------------------
      fill( failColor );
      text("Wykonałeś aż " + player.spaceHitCounter + " " + word1 + ".\nTo o " + (player.spaceHitCounter-1) + " " + word2 + " za dużo :)\n\nSpróbuj jeszcze raz", m2p(5), m2p(50) );
      return false;
    }
  }
}
