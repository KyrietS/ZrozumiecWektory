// Tytuł projektu + autorzy

class Level
{
  public String name;                                                // Nazwa poziomu
  public String description;                                         // Opis poziomu
  public Settings settings = new Settings();                         // Ustawienia poziomu.
  public ArrayList<Wall> walls = new ArrayList<Wall>();              // Tablica wszystkich ścian poziomu.
  public ArrayList<Text> texts = new ArrayList<Text>();              // Tablica wszystkich napisów poziomu.
  
// --------- KONSTRUKCJA POZIOMU --------- //
  
  Level( String levelPath )
  {
    loadLevel( levelPath );                                          // Wczytanie poziomu z pliku
  }
  
// ----- WYŚWEITLANIE PLANSZY ----- //
  
  public void show()
  {
    fill(#e8e8e8);
    rect( 0, 0, height, height );
    for( Wall wall : walls )
      wall.show();
    for( Text text : texts )
      text.show();
  }
  
// ------- KLASA WALL ------- //

  public class Wall
  {
    public ArrayList<PVector> vertices = new ArrayList<PVector>();
    public void show()
    {
      beginShape();
      fill( 255 );
      for( PVector ver : vertices )
        vertex( ver.x, ver.y );
      endShape( CLOSE );
    }
  }
  
// ------- KLASA TEXT ------- //

  public class Text
  {
    public String content = "...";
    public float x;
    public float y;
    public float rotation;
    public float fontSize;
    public  color col;

    public void show()
    {
      fill(col);  
      pushMatrix();
      textSize(fontSize);
      translate(this.x,this.y);
      rotate(this.rotation);
      text(this.content,0,0);
      popMatrix();
    }
  }
  
// ------- USTAWIENIA LEVELA ------- //
  
  public class Settings
  {
    public VectorType horizontalVectorType = VectorType.VELOCITY;
    public VectorType verticalVectorType = VectorType.VELOCITY;
    public float horizontalVectorMax = 100;
    public float verticalVectorMax = 50;
    public float horizontalVectorMin = 0;
    public float verticalVectorMin = 0;
    public float timeLimit = 60;
    public PVector startPos = new PVector(10, 50);
    public Settings()
    {
      // TODO: Wczytywanie ustawień z pliku zamiast ustalać to ręcznie.
      verticalVectorMax = m2p( verticalVectorMax );
      horizontalVectorMax = m2p( horizontalVectorMax );
      startPos.x = m2p( startPos.x );
      startPos.y = m2p( startPos.y );
    }
  }
// ------------------------------------------------------//
// Wczytywanie poziomu (ścian, tekstów i ustawień) z pliku
// ------------------------------------------------------//  
  private void loadLevel( String levelPath )
  {
    JSONObject level;
    try
    {
      level = loadJSONObject( levelPath );
    }
    catch( NullPointerException e )
    {
      println( "Nie udało się wczytać poziomu o podanej ścieżce: " + levelPath );
      return;
    }
    name = level.getString( "name" );
    description = level.getString( "description" );
    
    loadSettings( level.getJSONObject("settings") );
    loadWalls( level.getJSONArray("walls") );
    loadFinish( level.getJSONObject("finish") );
    loadTexts( level.getJSONArray("texts") );
    
  }
  private void loadSettings( JSONObject jSettings )
  {
    // TODO
  }
  private void loadWalls( JSONArray jWalls )
  {
    for( int i = 0; i < jWalls.size(); i++ )
    {
      Wall wall = new Wall();
      JSONObject jWall = jWalls.getJSONObject( i );
      JSONArray jVertices = jWall.getJSONArray("vertices");
      for( int j = 0; j < jVertices.size(); j++ )
      {
        JSONObject vertex = jVertices.getJSONObject(j);
        float x = m2p( vertex.getFloat("x") );
        float y = m2p( vertex.getFloat("y") );
        wall.vertices.add( new PVector(x, y ) );
      }
      walls.add( wall );
    }
  }
  private void loadFinish( JSONObject jFinish )
  {
    // TODO
  }
  private void loadTexts( JSONArray jTexts )
  {
    for( int i = 0; i < jTexts.size(); i++ )
    {
      Text text = new Text();
      JSONObject jText = jTexts.getJSONObject(i);
      text.content = jText.getString( "content" );
      text.fontSize = m2p( jText.getFloat( "font-size" ) );
      text.rotation = jText.getFloat( "rotation" );
      text.x = m2p( jText.getFloat("x") );
      text.y = m2p( jText.getFloat("y") );
      text.col = color( unhex(jText.getString("color") ) );
      texts.add( text );
    }
  }
 
}

public enum VectorType
{
  DISPLACEMENT, VELOCITY, ACCELERATION;
}