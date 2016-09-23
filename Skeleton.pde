public class Skeleton extends Bandit
{

  Skeleton(PVector pos)
  {
    super(pos);
    health = 15;
    damage = 2;
    vel = 0.0015;
    hitBox = 30;
    attackDelay = 60;
  }
  void display()
  {   
    image(skeleton, location.x, location.y);
  }
}