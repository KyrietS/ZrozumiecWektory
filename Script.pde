

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
      case "level14": level14Script(); break;
      case "level15": level15Script( gameplay ); break;
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
      case "level15": return level15WinScript( gameplay );
      default:        return defaultWinScript( gameplay );
    }
  }
  
// ----------------------------------------------------------------
  
  private void level07Script()
  {
    if( player.isFrozen )
      player.velocity = new PVector(0, -m2p(40) );
  }
  
// ----------------------------------------------------------------
  
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
  
// ----------------------------------------------------------------
  
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
  
// ----------------------------------------------------------------

private float temp14a = m2p( 80 );
private float temp14b = m2p( 100 );
private float temp14c = m2p( 56 );
private float temp14d = m2p( 35 );
  private void level14Script()
  {
    fill( #89b6ff );
    rect( m2p(35), 0, m2p(20), m2p(100) );
    if( player.pos.x > m2p(35) && player.pos.x < m2p(55) )
      player.pos.y -= m2p(30)/frameRate;

   
    if( temp14a < 0 ) temp14a = m2p( 100 );
    if( temp14b < 0 ) temp14b = m2p( 100 );
    if( temp14c < 0 ) temp14c = m2p( 100 );
    if( temp14d < 0 ) temp14d = m2p( 100 );
    fill( #c4daff );
    stroke( #FFFFFF );
    rect( m2p(37), temp14a, m2p(0.3), m2p(3) );
    rect( m2p(40), temp14b, m2p(0.3), m2p(2.5) );
    rect( m2p(48), temp14c, m2p(0.3), m2p(5) );
    rect( m2p(53), temp14d, m2p(0.3), m2p(3) );
    stroke( #000000 );
    
    temp14a -= m2p(30)/frameRate;
    temp14b -= m2p(30)/frameRate;
    temp14c -= m2p(30)/frameRate;
    temp14d -= m2p(30)/frameRate;
  }

// ----------------------------------------------------------------

  private void level15Script( Gameplay gameplay )
  {
    textSize( m2p(2.5) );
    fill(#646464);
    rect( 0, 0, m2p(100), m2p(100) );
    fill(#e8e8e8);
    ellipse( m2p(50), m2p(50), m2p(70), m2p(70) );
    fill(#646464);
    ellipse( m2p(50), m2p(50), m2p(50), m2p(50) );
    fill(#3BAA3D);
    rect( m2p(44), m2p(78), m2p(1), m2p(4) );
    fill(#646464);
    noStroke();
    rect( m2p(46), m2p(74), m2p(0.5), m2p(11.5) );
    stroke( 1 );
    fill( #FFFFFF );
    text( "Znajdujesz się w odległości 30 m od środka koła\nPrzyspieszenie dośrodkowe wynosi: 20 m/s²", m2p( 1 ), m2p( 7 ) );
    
    if( player.isFrozen == false )
    {
      float r = m2p(30);
      float x = m2p(50);
      float y = m2p(50);
      float a = m2p(20);
      float alpha = atan( (y - player.pos.y)/(player.pos.x - x) );
      if( player.pos.x < x )
        alpha += PI;
      //float aX = a*(x - player.pos.x)/r;
      //float aY = a*(y - player.pos.y)/r;
      float aX = -a * cos( alpha );
      float aY = a * sin( alpha );
      level.settings.horizontalVectorType = VectorType.ACCELERATION;
      level.settings.verticalVectorType = VectorType.ACCELERATION;
      player.realVector = new PVector( aX, aY );
      float playerR = sqrt( (player.pos.x - x)*(player.pos.x - x) + (player.pos.y - y)*(player.pos.y - y) );
      if( playerR + player.radius > m2p( 35 ) || playerR - player.radius < m2p(25) && false )
      {
        gameplay.currentFrame = Frame.COLLISION;
        gameplay.stopTimer();
        player.isFrozen = true;
      }
          
      
    }
    else
    {
      player.velocity.x = player.targetVector.x;
    }
    
  }

// ----------------------------------------------------------------
  
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
  
// ----------------------------------------------------------------
  
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
  
// ----------------------------------------------------------------
  
  private boolean level03WinScript()
  {
    fill(successColor);
    text("Podstawy działania gry już znasz.\nNdszedł czas, by Zrozumieć Wektory!", m2p(5), m2p(50) );
    return true;
  }
  
// ----------------------------------------------------------------
  
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
  
// ----------------------------------------------------------------
  
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
  
// ----------------------------------------------------------------
  
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
  
// ----------------------------------------------------------------
  
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
  
  private boolean level15WinScript( Gameplay gameplay )
  {
    fill( successColor );
    if( gameplay.getTime() < 4000 )
    {
      text("Gratulcje!\n\nNie da się już szybciej :-)", m2p(5), m2p(50) );
    }
    else
    {
      text("Gratulcje!\n\nCzy da się ten poziom przejść szybciej?", m2p(5), m2p(50) );
    }
    return true;
  }
}