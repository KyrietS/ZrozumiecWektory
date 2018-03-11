// Tytuł projektu + autorzy

class Level
{
  public Settings settings;                                          // Ustawienia poziomu.
  public ArrayList<Wall> walls = new ArrayList<Wall>();              // Tablica wszystkich ścian poziomu.
  
// --------- KONSTRUKCJA POZIOMU --------- //
  
  Level()
  {
    settings = new Settings();
    walls.add( new Wall() );
    walls.get( 0 ).vertices.add( new PVector(height*0.57,height*0.2857) );
    walls.get( 0 ).vertices.add( new PVector(height*0.7619,height*0.2857) );
    walls.get( 0 ).vertices.add( new PVector(height*0.7619,height*0.52381) );
    walls.get( 0 ).vertices.add( new PVector(height*0.57,height*0.52381) );
    walls.get( 0 ).vertices.add( new PVector(height*0.52381,height*0.381) );
  }
  
// ----- WYŚWEITLANIE PLANSZY ----- //
  
  public void show()
  {
    fill(#e8e8e8);
    rect( 0, 0, height, height );
    for( Wall wall : walls )
      wall.show();
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
 
}

public enum VectorType
{
  DISPLACEMENT, VELOCITY, ACCELERATION;
}