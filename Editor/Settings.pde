class Settings
{
  String name = "Nazwa poziomu";
  String description = "Opis poziomu";
  
  String horizontalVectorType = "velocity";
  float horizontalVectorMax = 100;
  float horizontalVectorMin = 0;
  
  String verticalVectorType = "displacement";
  float verticalVectorMax = 50;
  float verticalVectorMin = 0;
  
  int spacesLimit = 0;                                    // 0 = bez limitu
  int timeLimit = 0;                                      // 0 = bez limitu (czas w milisekundach)
  PVector startPos = new PVector( 50, 50 );
  
}