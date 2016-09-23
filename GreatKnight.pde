public class GreatKnight extends Bandit
{

  GreatKnight(PVector pos)
  {
    super(pos);
    health = 40;
    damage = 10;
    vel = 0.0017;
    hitBox = 65;
    attackDelay = 70;
  }
  void display()
  {   
    if (location.x <= width/2) {
      image(greatKnight2, location.x, location.y);
    } else { 
      image(greatKnight, location.x, location.y);
    }
  }
}