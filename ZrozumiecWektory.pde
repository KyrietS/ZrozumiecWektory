import java.awt.event.KeyEvent;
GameEngine engine;

void setup()
{
  size( 1200, 800 );
  frameRate( 60 );
  engine = new GameEngine();
}

void draw()
{
  background( 200 );
  engine.update();
}

void keyPressed()
{
  switch( keyCode )
  {
    case KeyEvent.VK_W: ActiveKey.W = true; break;
    case KeyEvent.VK_A: ActiveKey.A = true; break;
    case KeyEvent.VK_S: ActiveKey.S = true; break;
    case KeyEvent.VK_D: ActiveKey.D = true; break;
    case KeyEvent.VK_SPACE: ActiveKey.SPACE = true; break;
  }
}

void keyReleased()
{
  switch( keyCode )
  {
    case KeyEvent.VK_W: ActiveKey.W = false; break;
    case KeyEvent.VK_A: ActiveKey.A = false; break;
    case KeyEvent.VK_S: ActiveKey.S = false; break;
    case KeyEvent.VK_D: ActiveKey.D = false; break;
    case KeyEvent.VK_SPACE: ActiveKey.SPACE = false; break;
  }
}

public static class ActiveKey
{
  static boolean W = false;
  static boolean A = false;
  static boolean S = false;
  static boolean D = false;
  static boolean SPACE = false;
}