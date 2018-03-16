class Text
{
  public float x;
  public float y;
  public String text;
  public color mycolor;
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
  }
  public void show()
  {
    fill(this.mycolor);
    text(this.text,this.x,this.y);
  }
}  
