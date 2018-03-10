class Level
{
  public Settings settings;
  Level()
  {
    settings = new Settings();
  }
  public class Settings
  {
    public VectorType horizontalVectorType = VectorType.VELOCITY;
    public VectorType verticalVectorType = VectorType.DISPLACEMENT;
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