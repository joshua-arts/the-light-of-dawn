public class Behemoth extends Bandit
{
  
  Behemoth(PVector pos)
  {
    super(pos);
    health = 100;
    damage = 10;
    vel = 0.001;
    hitBox = 75;
    attackDelay = 50;
  }
  void display()
  {   
    if(location.x <= width/2){
    image(behemoth,location.x,location.y);
    }else{ 
       image(behemoth2,location.x,location.y);
    }
  }
  
}