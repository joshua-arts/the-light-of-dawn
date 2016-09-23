public class Bandit 
{
  PVector location;
  int health = 10;
  int damage = 1;
  float vel = 0.001;
  float dx, dy ;
  int hitBox = 15;
  int attackDelay = 50;
  int timer = 0;
  boolean hitByStone = false;
  boolean displayThunder;
  Bandit(PVector pos)
  {
    location = new PVector(pos.x, pos.y);
  }
  //Display enemy
  void display()
  {   
    image(bandit, location.x, location.y);
  }
  //Update location of enemy
  void update()
  {
    dx = location.x -  width/2;
    dy = location.y - height/2;

    if (location.x >= castleBoundWest - hitBox && location.x <= castleBoundEast
      && location.y >= castleBoundNorth - hitBox && location.y <= castleBoundSouth)
    {
    } else {
      location.x -= dx * vel;
      location.y -= dy * vel;
    }
  }
  //Check if enemy is hit
  void checkHit()
  {
    if (attacked == true  && ((mouseX >= location.x - hitBox) && (mouseX <= location.x + hitBox)) && 
      ((mouseY >= location.y - hitBox) && (mouseY <= location.y + hitBox)))
    {
      health -= playerDamage;
      fill(255);
      text(playerDamage, location.x, location.y - 20);
      attacked = false;
    }

    if (stoneUsed == true && this.hitByStone == false)
    { 
      health -= stoneDamage;
      fill(230, 230, 0);
      text(stoneDamage, location.x + 20, location.y - 20); 
      this.hitByStone= true;
    } 
    if (stoneUsed == false)
    {
      this.hitByStone = false;
    }

    if (thunderUsed == true && ((mouseX >= location.x - hitBox) && (mouseX <= location.x + hitBox)) && 
      ((mouseY >= location.y - hitBox) && (mouseY <= location.y + hitBox))) {

      this.displayThunder = true;  
      thunderUsed = false;
      fill(230, 230, 0);
      text(thunderDamage, location.x + 20, location.y - 20);
    }

    if (this.displayThunder == true) {
      stoneStrike(location.x - 100, location.y - 150, this);
    }
  } 
  //Check if enemy is alive
  boolean checkHealth()
  {
    if (health <= 0) {
      return true;
    } else {
      return false;
    }
  }
  //Check if enemy is in range to damage castle
  void damageCastle()
  {
    if (location.x >= castleBoundWest - hitBox && location.x <= castleBoundEast
      && location.y >= castleBoundNorth - hitBox && location.y <= castleBoundSouth)
    {
      timer ++;
      if (timer == attackDelay) {

        if (eastSoldiersUp == true && location.x >= width/2 && location.y >= castleBoundNorth 
          && location.y <= castleBoundSouth) {
          eastSoldierHealth -= damage;
        }
        if (westSoldiersUp == true && location.x <= width/2 && location.y >= castleBoundNorth  
          && location.y <= castleBoundSouth - hitBox) {
          westSoldierHealth -= damage;
        }
        if (northSoldiersUp == true && location.y <= height/2 && location.x >= castleBoundWest 
          && location.x <= castleBoundEast - hitBox) {
          northSoldierHealth -= damage;
        }
        if (southSoldiersUp == true && location.y >= height/2 && location.x >= castleBoundWest  
          && location.x <= castleBoundEast) {
          southSoldierHealth -= damage;
        } 

        if (location.x >= ((width/2) - castlewidth/2 - hitBox) && location.x <= ((width/2) - castlewidth/2) + castlewidth + hitBox
          && location.y >= ((height/2) - castlewidth/2 - hitBox) && location.y <= ((height/2) - castlewidth/2) + castlewidth + hitBox) {
          castlehealth -= damage;
        }
        timer = 0;
      }
    }
  }
}