public class Werewolf extends Bandit
{

  Werewolf(PVector pos)
  {
    super(pos);
    health = 10;
    damage = 2;
    vel = 0.003;
    hitBox = 40;
    attackDelay = 30;
  }
  void display()
  {   
    if (location.x <= width/2) {
      image(werewolf2, location.x, location.y);
    } else { 
      image(werewolf, location.x, location.y);
    }
  }
}