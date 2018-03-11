class Level
{
  public Settings settings;
  public ArrayList<Wall> walls = new ArrayList<Wall>();
  Level()
  {
    settings = new Settings();
    walls.add( new Wall() );
    walls.get( 0 ).vertices.add( new PVector(600,300) );
    walls.get( 0 ).vertices.add( new PVector(800,300) );
    walls.get( 0 ).vertices.add( new PVector(800,550) );
    walls.get( 0 ).vertices.add( new PVector(600,550) );
    walls.get( 0 ).vertices.add( new PVector(550,400) );
  }
  public void show()
  {
    for( Wall wall : walls )
      wall.show();
  }
  public class Wall
  {
    public ArrayList<PVector> vertices = new ArrayList<PVector>();
    public void show()
    {
      beginShape();
      for( PVector ver : vertices )
        vertex( ver.x, ver.y );
      endShape( CLOSE );
    }
  }
  public class Settings
  {
    public VectorType horizontalVectorType = VectorType.VELOCITY;
    public VectorType verticalVectorType = VectorType.VELOCITY;
    public float horizontalVectorMax = 500;
    public float verticalVectorMax = 500;
    public float horizontalVectorMin = 0;
    public float verticalVectorMin = 0;
    public float timeLimit = 60;
    public PVector startPos = new PVector(400, 400);
    public Settings()
    {
      // TODO: Wczytywanie ustawień z pliku zamiast ustalać to ręcznie.
      
    }
  }
 
}

public enum VectorType
{
  DISPLACEMENT, VELOCITY, ACCELERATION;
}