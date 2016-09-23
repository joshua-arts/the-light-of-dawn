public class Goblin extends Bandit
{

  Goblin(PVector pos)
  {
    super(pos);
    health = 5;
    damage = 1;
    vel = 0.0025;
    hitBox = 35;
    attackDelay = 10;
  }
  void display()
  {   
    if (location.y <= height/2) {
      image(goblin, location.x, location.y);
    } else { 
      image(goblin2, location.x, location.y);
    }
  }
}