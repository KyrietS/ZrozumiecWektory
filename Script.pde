

public class Script
{
  color successColor = #3f88ff;
  color warningColor = #c1a100;
  color failColor    = #f44842;
  
  public void runGameplayScript( String levelID, Gameplay gameplay )
  {
    switch( levelID )
    {
      case "level07": level07Script(); break;
      case "level12": level12Script( gameplay ); break;
      case "level13": level13Script( gameplay ); break;
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
      case "level12": return level12WinScript();
      case "level13": return level13WinScript();
      default:        return defaultWinScript( gameplay );
    }
  }
  
  private void level07Script()
  {
    if( player.isFrozen )
      player.velocity = new PVector(0, -m2p(40) );
  }
  
  private float temp12;
  private void level12Script( Gameplay gameplay )
  {
    
    if( player.isFrozen == false )
    {
      float k = 0.2;
      player.realVector.x = player.realVector.x - k*player.realVector.x/frameRate;
      player.velocity.y = player.velocity.y - k*player.velocity.y/frameRate;
    }
    else
    {
      player.velocity = new PVector(0, -m2p(40) );
    }
    
    //println( gameplay.getTime() );
    //print( "" + p2m( m2p(84) - player.pos.y ) + " --- " + temp12 + "\n" );
    if( gameplay.getTime() == 0 )
      temp12 = 3;
    else if( p2m( m2p(84) - player.pos.y ) > temp12 )
      temp12 = p2m( m2p(84) - player.pos.y );
    
  }
  
  private float temp13;
  private void level13Script( Gameplay gameplay )
  {
    if( player.isFrozen == false )
    {
      float k = 0.003;
      player.realVector.x = player.realVector.x - k*(player.realVector.x*player.realVector.x)/frameRate;
      if( player.velocity.y > 0 )
        k *= -1;
      player.velocity.y = player.velocity.y + k*(player.velocity.y*player.velocity.y)/frameRate;
    }
    else
    {
      player.velocity = new PVector(0, -m2p(100) );
    }
    
    if( gameplay.getTime() == 0 )
      temp13 = 3;
    else if( p2m( m2p(84) - player.pos.y ) > temp13 )
      temp13 = p2m( m2p(84) - player.pos.y );
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
      text("Gratulacje!\nDokładnie tak należało rozwiązać to zadanie.\n\nPS. Czas takiego ruchu wynosi oczywiście 0 sekund, ale to,"
        + "\nco jest napisane wyżej, to czas renderowania pojedynczej\nklatki gry, w której nastąpił \"przeskok\".", m2p(5), m2p(50) );
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
  
  private boolean level12WinScript()
  {
    if( temp12 >= 60 )
    {
      fill( successColor );
      text("Gratulcje!\n\nTwoja wysokość wyniosła: " + (float)round( temp12 * 100 )/100 + " m", m2p(5), m2p(50) );
      return true;  
    }
    else
    {
      fill( failColor );
      text("Piłeczka nie wzniosła się na wymaganą wysokość.\n\nTwoja wysokość wyniosła: " + (float)round( temp12 * 100 )/100 + " m", m2p(5), m2p(50) );
      return false;  
    }
  }
  
    private boolean level13WinScript()
  {
    if( temp13 >= 60 )
    {
      fill( successColor );
      text("Gratulcje!\n\nTwoja wysokość wyniosła: " + (float)round( temp13 * 100 )/100 + " m", m2p(5), m2p(50) );
      return true;  
    }
    else
    {
      fill( failColor );
      text("Piłeczka nie wzniosła się na wymaganą wysokość.\n\nTwoja wysokość wyniosła: " + (float)round( temp13 * 100 )/100 + " m", m2p(5), m2p(50) );
      return false;  
    }
  }
}