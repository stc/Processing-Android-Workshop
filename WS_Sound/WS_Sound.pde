Maxim maxim;
AudioPlayer player;
float go;
boolean playit;

void setup() 
{
  size(displayWidth,displayHeight, P3D); 

  frameRate(25); 
  maxim = new Maxim(this);
  player = maxim.loadFile("mybeat.wav");
  player.setLooping(true);
  player.setAnalysing(true);
  player.play();
    
  noStroke();
  background(0);
}

void draw() 
{
  background(0);
  
  float power = player.getAveragePower();
  go = power * 500;
  
  ellipse(mouseX, mouseY, go, go);
  
  player.speed((float) mouseX / (float) width);
}

void mousePressed() 
{
  /*
  playit = !playit;
  if (playit) 
  {
    player.play();
  } 
  else 
  {
    player.stop();
  }
  */
}

