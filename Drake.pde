public class Drake extends Bandit
{
  
  Drake(PVector pos)
  {
    super(pos);
    health = 200;
    damage = 50;
    vel = 0.00035;
    hitBox = 130;
    attackDelay = 200;
  }
  void display()
  {   
    if(location.x <= width/2){
    image(drake,location.x,location.y);
    }else{ 
       image(drake2,location.x,location.y);
    }
  }
  
}