public class Ogre extends Bandit
{
  
  Ogre(PVector pos)
  {
    super(pos);
    health = 75;
    damage = 15;
    vel = 0.0005;
    hitBox = 75;
    attackDelay = 150;
  }
  void display()
  {   
    if(location.y <= height/2){
    image(ogre,location.x,location.y);
    }else{ 
       image(ogre2,location.x,location.y);
    }
  }
  
}