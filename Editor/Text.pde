import java.awt.event.KeyEvent;

class Text
{
  public float x;
  public float y;
  public color col;
  public String content = new String();
  public float rotation = 0;
  public int size = 32;
  
  Text(int x,int y,color col)
  {
    this.col=col;
    this.x = x;
    this.y = y;
  }
  
  public void addLetter(char letter)
  {
    if( (int)letter == 8 && content.length() > 0 )
      content = content.substring(0, content.length()-1 );
    else
      content += letter;
  }
  
  public void setSize(int pageKey)
  {
    switch( pageKey )
    {
      case KeyEvent.VK_PAGE_UP:   size += 1; break;
      case KeyEvent.VK_PAGE_DOWN: size -= 1; break;
    }
  }
  public void move(int arrowKey)
  {
    switch( arrowKey )
    {
      case UP: this.y -= 2;   break;
      case DOWN: this.y += 2; break;
      case LEFT: this.x -= 2; break;
      case RIGHT: this.x +=2; break;
    }
  }
  public void setRotation( float angle )
  {
    this.rotation += angle;
  }

  public void show()
  {
    this.show( this.col );
  }

  public void show( color col )
  {
    fill(col);  
    pushMatrix();
    textSize(size);
    translate(this.x,this.y);
    rotate(this.rotation);
    text(this.content,0,0);
    popMatrix();
    textSize(32);
  }
}  