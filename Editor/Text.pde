class Text
{
  public float x;
  public float y;
  public String text;
  public color mycolor;
  public float angle;
  public void AddLetter(char letter)
  {
    this.text=this.text + letter;
  }
  Text(int x,int y,color col)
  {
    this.mycolor=col;
    this.x = x;
    this.y = y;
    this.text="";
    this.angle = 0;
  }
  public void show()
  {
    fill(this.mycolor);
    textAlign(CENTER);
    translate(this.x,this.y);
    rotate(this.angle);
    text(this.text,0,0);
    rotate((-1)*this.angle);
    translate(-this.x,-this.y);
    textAlign(LEFT);
  }
}  
