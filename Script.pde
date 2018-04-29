

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
      case "level16": level16Script(); break;
      case "level17": level17Script(); break;
      case "level18": level18Script(); break;
    }
  }
  
  public boolean runWinScript( String levelID, Gameplay gameplay )
  {
    switch( levelID )
    {
      case "level02": return level02WinScript( gameplay );
      case "level03": return level03WinScript();
      case "level07": return level07WinScript( gameplay );
      case "level10": return level10WinScript( gameplay );
      case "level12": return level12WinScript();
      case "level13": return level13WinScript();
      case "level15": return level15WinScript( gameplay );
      case "level18": return level18WinScript();
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
      if( playerR + player.radius > m2p( 35 ) || playerR - player.radius < m2p(25) )
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

  private void level16Script()
  {
    if( player.isFrozen )
      player.velocity = new PVector(0, -m2p(40) );
  }

// ----------------------------------------------------------------

  private float temp17[] = {m2p(10), m2p(35), m2p(56), m2p(67) ,m2p(74), m2p(90)};
  private void level17Script()
  {
    for( int i = 0; i < temp17.length; i++ )
    {
      if( temp17[ i ] < 0 )
        temp17[ i ] = m2p(100);
      temp17[i] -= m2p(40)/frameRate;
    }
    
    stroke( #a8a8a8 );
    line( temp17[0], m2p(20), temp17[0] + m2p(3), m2p(20) );
    line( temp17[1], m2p(80), temp17[1] + m2p(6), m2p(80) );
    line( temp17[2], m2p(64), temp17[2] + m2p(4), m2p(64) );
    line( temp17[3], m2p(75), temp17[3] + m2p(4), m2p(75) );
    line( temp17[4], m2p(55), temp17[4] + m2p(3), m2p(55) );
    line( temp17[5], m2p(40), temp17[5] + m2p(4), m2p(40) );
    stroke(0);
    
    if( player.isFrozen == false )
    {
      float Ay = m2p(10);
      float Ax = m2p(15);
      player.realVector.x -= Ax/frameRate;
      player.realVector.y += Ay/frameRate;
    }
  }

// ----------------------------------------------------------------

  private float temp18[] = {/*I Rzeka*/m2p(80), m2p(100), m2p(56), m2p(35),/*II Rzeka*/ m2p(52), m2p(16), m2p(17), m2p(59), m2p(39), m2p(2) ,m2p(37),m2p(35),m2p(30),m2p(80)};
  private void level18Script()
  {
    noStroke();
    fill( #89b6ff );
    float x1 ,x2, y1, y2;
    x1 = 3.2050807569;
    y1 = 100;
    x2 = 33.2050807569;
    y2 = 100;
    quad( m2p(30), 0, m2p(60), m2p(0) ,m2p(x2),m2p(y2),m2p(x1),m2p(y1));
    rect( m2p(75), 0, m2p(15), m2p(100) );
    
     float fi = -3.7320508076;
    if(p2m(player.pos.y)>(fi*p2m(player.pos.x) + (y1-fi*x1))&&p2m(player.pos.y)<(fi*p2m(player.pos.x) + (y2-fi*x2)))
    {
      player.pos.y += m2p(30)*sin(radians(75))/frameRate;
      player.pos.x -= m2p(30)*cos(radians(75))/frameRate;

    }
    if( player.pos.x > m2p(75) && player.pos.x < m2p(90) )
      player.pos.y -= m2p(15)/frameRate;
   
    fill( #c4daff );
    stroke( #FFFFFF );
    
    rect( m2p(76), temp18[ 0 ], m2p(0.3), m2p(3) );
    rect( m2p(80), temp18[ 1 ], m2p(0.3), m2p(2.5) );
    rect( m2p(84), temp18[ 2 ], m2p(0.3), m2p(5) );
    rect( m2p(89), temp18[ 3 ], m2p(0.3), m2p(3) );
    for( int i = 0; i <= 3; i++ )
    {
      if( temp18[ i ] < 0 )
        temp18[ i ] = m2p( 100 );
      temp18[ i ] -= m2p( 15 )/frameRate;
    }
    float length1,length2,length3,length4,length5;
    length1 =6;
    length2 = 7;
    length3 = 8;
    length4 = 7;
    length5=10;
    quad(temp18[4],temp18[5],
    temp18[4]+m2p(0.3)*cos(radians(15)),temp18[5]+m2p(0.3)*sin(radians(15)),
    temp18[4]+m2p(0.3)*cos(radians(15))-m2p(length1)*cos(radians(75)),temp18[5]+m2p(0.3)*sin(radians(15))+m2p(length1)*sin(radians(75)),
    temp18[4]-m2p(length1)*cos(radians(75)),temp18[5]+m2p(length1)*sin(radians(75)));
    quad(temp18[6],temp18[7],
    temp18[6]+m2p(0.3)*cos(radians(15)),temp18[7]+m2p(0.3)*sin(radians(15)),
    temp18[6]+m2p(0.3)*cos(radians(15))-m2p(length2)*cos(radians(75)),temp18[7]+m2p(0.3)*sin(radians(15))+m2p(length2)*sin(radians(75)),
    temp18[6]-m2p(length2)*cos(radians(75)),temp18[7]+m2p(length2)*sin(radians(75)));
    quad(temp18[8],temp18[9],
    temp18[8]+m2p(0.3)*cos(radians(15)),temp18[9]+m2p(0.3)*sin(radians(15)),
    temp18[8]+m2p(0.3)*cos(radians(15))-m2p(length3)*cos(radians(75)),temp18[9]+m2p(0.3)*sin(radians(15))+m2p(length3)*sin(radians(75)),
    temp18[8]-m2p(length3)*cos(radians(75)),temp18[9]+m2p(length3)*sin(radians(75)));
    quad(temp18[10],temp18[11],
    temp18[10]+m2p(0.3)*cos(radians(15)),temp18[11]+m2p(0.3)*sin(radians(15)),
    temp18[10]+m2p(0.3)*cos(radians(15))-m2p(length4)*cos(radians(75)),temp18[11]+m2p(0.3)*sin(radians(15))+m2p(length4)*sin(radians(75)),
    temp18[10]-m2p(length4)*cos(radians(75)),temp18[11]+m2p(length4)*sin(radians(75)));
    quad(temp18[12],temp18[13],
    temp18[12]+m2p(0.3)*cos(radians(15)),temp18[13]+m2p(0.3)*sin(radians(15)),
    temp18[12]+m2p(0.3)*cos(radians(15))-m2p(length5)*cos(radians(75)),temp18[13]+m2p(0.3)*sin(radians(15))+m2p(length5)*sin(radians(75)),
    temp18[12]-m2p(length5)*cos(radians(75)),temp18[13]+m2p(length5)*sin(radians(75)));
    
    for( int i = 4; i <= 13; i++ )
    {
      if( temp18[ i ] > m2p(100)&&i%2==1 ){
        temp18[ i ] = 0;
        temp18[i-1]=temp18[i-1]+m2p(26.79491924311227064);
      }
      if(i%2==1)
      {
      temp18[ i ] += m2p(30)*sin(radians(75))/frameRate;
      }
      else
      {
      temp18[i]-=m2p(30)*cos(radians(75))/frameRate;
      }
    }
    
    stroke( #000000 );
    
    // ------ NAPISY ------- //
    
    fill( 0 );
    textFont( bloggerSans );
    textSize( m2p(2) );
    text( "↓ Vr' = 30 m/s", m2p(31), m2p(8) );
    text( "↑ Vr'' = 15 m/s", m2p(76), m2p(8) );
    textFont( bloggerSansBold );
    textSize( m2p(2) );
    text( " ------------- 30 m -------------", m2p(4), m2p(97) );
    char znakStopnia = 176;
    text( "75"+znakStopnia,m2p(36),m2p(94));
    noFill();
    arc(m2p(36),m2p(94),m2p(10),m2p(10),PI+HALF_PI+radians(15),TWO_PI);
    text( " ---------- 26.8 m ----------", m2p(34), m2p(97) );
    text( " ----- 15 m ----", m2p(60), m2p(97) );
    text( " ----- 15 m ----", m2p(75), m2p(97) );
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
  
  private boolean level10WinScript( Gameplay gameplay )
  {
    if( player.spaceHitCounter == 1 )
    {
      fill( successColor );
      text("Gratulacje!\nDokładnie tak należało rozwiązać to zadanie.", m2p(5), m2p(50) );
      if( gameplay.getTime() != 0 )
      {
        text("PS. Czas takiego ruchu wynosi oczywiście 0 ms, ale to,"
        + "\nco jest napisane wyżej, to czas renderowania pojedynczej\nklatki gry, w której nastąpił \"przeskok\".", m2p(5), m2p(63) );
      }
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
  
  private boolean level18WinScript()
  {
    fill( successColor );
    text("Gratulacje!\nWłaśnie ukończyłeś ostatni poziom przewidziany w tej\ngrze.\n\nMamy nadzieję, że się dobrze bawiłeś, Drogi Graczu!", m2p(5), m2p(50) );
    return true; 
  }
}
