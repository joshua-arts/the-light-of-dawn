public class Ram extends Bandit
{

  Ram(PVector pos)
  {
    super(pos);
    health = 50;
    damage = 40;
    vel = 0.0005;
    hitBox = 35;
    attackDelay = 150;
  }
  void display()
  {   
    image(ram, location.x, location.y);
  }
}