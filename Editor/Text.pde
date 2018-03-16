class Text
{
  public float x;
  public float y;
  public String text;
  public color mycolor;
  public float angle;
  public int size;
  public void addLetter(char letter)
  {
    this.text=this.text + letter;
  }
  public boolean textManagment(int s)
  {
      if(s==UP||s==DOWN||s==RIGHT||s==LEFT)
      {
        textMove(s);
        return true;
      }
      else if(s==33||s==34)
      {
        textResize(s);
        return true;
      }
      return false;
  }
  public void textMove(int s)
  {
      if(s==UP)
      {
        this.y-=2;
      }
      else if(s==DOWN)
      {
        this.y+=2;
      }
      else if(s==LEFT)
      {
        this.x-=2;
      }
      else if(s==RIGHT)
      {
        this.x+=2;
      }
  }
  public void textResize(int s)
  {
      if(s==33)
      {
        this.size+=1;
      }
      else if(s==34)
      {
        this.size-=1;
      }
  }
  Text(int x,int y,color col)
  {
    this.mycolor=col;
    this.x = x;
    this.y = y;
    this.text="";
    this.angle = 0;
    this.size = 32;
  }

  public void show()
  {
    fill(this.mycolor);  
    pushMatrix();
    textSize(size);
    translate(this.x,this.y);
    rotate(this.angle);
    text(this.text,0,0);
    popMatrix();
    textSize(32);
  }
}  
