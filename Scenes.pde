interface Scene
{
  void update();
}

class HomeScene implements Scene
{
  Button playButton;
  HomeScene()
  {
    playButton = new Button("play", "Zagraj", 40, 40, 20, 10, #26ad96 );
  }
  
  void update()
  {
    fill(#dbffe6 );
    rect( 0, 0, m2p(100), m2p(100) );
    playButton.show();
  }
}