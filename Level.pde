class Level
{
  public Settings settings;
  Level()
  {
    settings = new Settings();
  }
  public class Settings
  {
    public VectorType horizontalVectorType = VectorType.ACCELERATION;
    public VectorType verticalVectorType = VectorType.VELOCITY;
    public float horizontalVectorLimit = 500;
    public float verticalVectorLimit = 500;
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