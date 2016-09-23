/*
The Light of Dawn 
 
Developed by Joshua Arts, Michael Calabro, and Andrew Dodge.
 
NOTE: We are using sound library ddf.minim.
 */

import ddf.minim.*;

AudioPlayer player;
AudioPlayer title;
AudioPlayer NoneShallLive;
AudioPlayer Archangel;
AudioPlayer Neverdark;
AudioPlayer United;
AudioPlayer RiseAbove;
AudioPlayer Starfall;
AudioPlayer TheLastStand;
AudioPlayer FireNation;
AudioPlayer BlackBlade;
AudioPlayer Invincible;
AudioPlayer Thousand;
AudioPlayer Bastion;
AudioPlayer Stronger;
AudioPlayer FlameHeart;
AudioPlayer Protectors;
AudioPlayer DragonRider;
AudioPlayer TitanDune;
AudioPlayer ArmyOfJustice;
AudioPlayer ToGlory;
AudioPlayer Riders;

Minim minim;

AudioPlayer[] songList = {NoneShallLive, Archangel, Neverdark, United, RiseAbove, Starfall, 
  TheLastStand, FireNation, BlackBlade, Invincible, Thousand, Bastion, 
  Stronger, FlameHeart, Protectors, DragonRider, TitanDune, ArmyOfJustice, 
  ToGlory, Riders};
boolean songPlaying = false;   
int index;


//-------------------------------------Menu initialize--------------------------------------
PImage one, two, icon, creditNight, baseMinion, rotatedMinion;
PFont titlefont; 
PFont dayfont;
int x = 0;
Minion[] currentMinions = new Minion[12];
int minionCount = 0;
String menuState = "Day";
String gameState = "";
boolean onMenu = true;
int tileSize = 32;
int widthMenuOffset = 4;
int heightMenuOffset = 8;
int[] menuPathX = {9, 10, 11, 12, 12, 13, 14};
int[] menuPathY = {11, 11, 11, 11, 10, 10, 10};
int menuPathStage = 0;
int titlecounter = 0, startcounter = 600;
PImage flamesheet, currentframe, redStar;
PImage introScreen;
int xflame = 0, yflame = 0, xStar = 0, yStar = 0;
int creditCount = 0, creditX, creditY, creditC;
String creditNames[] = {"Joshua Arts", "Michael Calabro", "Andrew Dodge"};

//------------------------------------Day initialize----------------------------------------
PImage iconBig, iconSheet;
PImage coin, logs, soldiers, metal, stone, towers, food; // RESOURCE ICONS.
PImage armoury, barracks, castle, market, quarry, mill, refinery, farm; // BUILDING IMAGES.
int selectorX = 4;
int selectorY = 4;
int squareID = 0; // ID of selected square.
int posNum = 0;
int posNumPress = 0;
int buildID = 11;
int resourceTicks = 0;
int iconPortion = 1;
int iconDelay = 0;
int iconDirection = 1;

int hours = 12;

boolean updateSquareID = true;

boolean stoneUnlocked = false;
boolean thunderUnlocked = false;

boolean dagger = false;
boolean hammer = false;
boolean axe = false;
boolean sword = false;

// Array to store images in (done in setup).
PImage buildingImages[] = {null, null, null, null, null, null, null, null, null};

// Array to store build requirements.
String buildRequirements[][] = {{"- 50 Gold", "- 10 Wood", "-2 Hours"}, // MARKET
  {"- 50 Gold", "- 20 Wood", "- 3 Hours"}, // MILL
  {"- 100 Gold", "- 10 Wood", "- 3 Hours"}, // FARM
  {"- 100 Gold", "- 20 Stone", "- 3 Hours"}, 
  {"- 200 Gold", "- 40 Stone", "- 4 Hours"}, 
  {"- 250 Gold", "- 10 Metal", "- 4 Hours"}, 
  {"- 300 Gold", "- 20 Metal", "- 4 Hours"}};
String buildingDoes[][] = {{"Allows you to convert time into gold", "1 Hour = 5 Gold per market"}, // MARKET
  {"Allows you to convert time into wood", "1 Hour = 5 Wood per mill"}, // MILL
  {"Allows you to convert time into food", "1 Hour = 5 Food per farm"}, // FARM
  {"Allows you to convert time into stone", "1 Hour = 5 Stone per quarry"}, 
  {"Allows you to convert time into metal", "5 Stone = 1 Metal"}, 
  {"Allows you to buy soldiers to defend the castle", "50 Food = 1 Group of soldiers"}, 
  {"Allows you to upgrade your weapons"}};

String buildingNames[] = {"Market", "Mill", "Farm", "Quarry", "Refinery", "Barracks", "Armoury"};

/*

 Resource ID's
 
 0 = gold
 1 = wood
 2 = stone
 3 = food
 4 = metal
 5 = soliders
 6 = towers
 */

int resources[] = {100, 100, 100, 50, 50, 0, 0};

int goldIncome = 0;
int woodIncome = 0;
int stoneIncome = 0;
int foodIncome = 0;
boolean incomeRecieved = true;

/*

 Number to Building & Number to Menu Information
 
 0 = empty space
 1 = castle
 2 = market
 3 = mill
 4 = farm
 5 = quarry
 6 = refinery
 7 = barracks
 8 = armoury
 
 9 = divide number
 
 10 = repair submenu
 11 = build menu
 
 */

int grid[][] = {{0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 1, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0}};

// 0 means not upgraded.
// 1 means upgraded.
// 2 means castle.
int upgradeData[][] = {{0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 2, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0}};

// The menu options for each building type.

String menuOptions[][] = {{"Build"}, // (0) EMPTY
  {"Repair", "Sleep"}, // (1) CASTLE
  {"Work market", "Upgrade", "Destroy"}, // (2) MARKET
  {"Work mill", "Upgrade", "Destroy"}, // (3) MILL
  {"Work farm", "Upgrade", "Destroy"}, // (4) FARM
  {"Work quarry", "Upgrade", "Destroy"}, // (5) QUARRY
  {"Refine", "Destroy"}, // (6) REFINERY
  {"Buy soldiers", "Destroy"}, // (7) BARRACKS
  {"Weapons", "Stone Strike", "Stone Burst"}, // (8) // ARMOURY
  {"----------"}, // DIVIDE BETWEEN BUILDINGS AND SUBMENUS.
  {"Repair 50", "Repair 100", "Repair 500", "Back"}, // REPAIR SUBMENU.
  {"Market", "Mill", "Farm", "Quarry", "Refinery", "Barracks", "Armoury", "Back"}, // BUILD SUBMENU.
  {"Dagger", "Hammer", "War Axe", "Longsword"}};
//------------------------------------Night initialize-------------------------------------

int castlewidth = 276;
int castleBoundWest, castleBoundEast, castleBoundNorth, castleBoundSouth;
int castlehealth;
int maxcastlehealth = 500;
int playerNightX, playerNightY;
int stopX, stopY;
Bandit banditArray[];
Skeleton skeletonArray[];
Werewolf werewolfArray[];
Goblin goblinArray[];
Ram ramArray[];
GreatKnight greatKnightArray[];
Ogre ogreArray[];
Behemoth behemothArray[];
Drake drakeArray[];
int numBandits = 5, numSkeletons = 0, numWerewolves = 0, numGoblins = 0, numRams = 0, 
  numGreatKnights = 0, numOgres = 0, numBehemoths = 0, numDrakes = 0;
int numEnemies = numBandits + numSkeletons + numWerewolves + numGoblins + numRams
  + numGreatKnights + numOgres + numBehemoths + numDrakes; 
boolean attacked;
PImage nightbackground, playerSheet, playerFrame, clouds;
PImage bandit, skeleton, werewolf, werewolf2, goblin, goblin2, ram, greatKnight, greatKnight2, 
  ogre, ogre2, behemoth, behemoth2, drake, drake2; // Enemies
PImage gameOverScreen, nightFade, bloodFade;
PImage soldiernorth, soldiersouth, soldiereast, soldierwest; //Soldiers 
PImage magicIcon, lightningIcon, barBG, healthBar, lockIcon;
int fadeTimer = -800;
int bloodFadeTimer = -600;
int xPlayer = 0, yPlayer = 0;
int playerState = 0;
int previousMoveNight;
int nightCounter = 1;
int waveCounter = 0;
boolean wavesOver = false;
boolean onNight = false;
int playerDamage = 10;
int stoneDamage = 10, stoneTimer = 0, stoneCD = 120, stoneCDtimer = stoneCD;
boolean stoneUsed = false;
PImage thunder, thunderFrame, xCross;
int xThunder = 0, yThunder = 0;
boolean thunderUsed = false;
int thunderDamage = 10, thunderCD = 120, thunderCDtimer = thunderCD;
boolean eastSoldiersUp = false, westSoldiersUp = false, northSoldiersUp = false, southSoldiersUp = false;
boolean eastUpdated = false, westUpdated = false, northUpdated= false, southUpdated = false;
int soldierHealth = 20, eastSoldierHealth = soldierHealth, westSoldierHealth = soldierHealth, 
  northSoldierHealth = soldierHealth, southSoldierHealth = soldierHealth;

//--------------------------------Main Functions-------------------------------------------
void setup() {
  size(800, 600);
  titlefont = createFont("Canterbury.ttf", 50);
  dayfont = createFont("Konkor-48.vlw", 50);
  textFont(titlefont);
  frameRate(2); // While we're in the menu phase only.
  one = loadImage("day.png");
  two = loadImage("night.png");
  icon = loadImage("selector.png");
  creditNight = loadImage("creditnight.png");
  flamesheet = loadImage("flames.png");
  redStar = loadImage("starRed.png");
  baseMinion = loadImage("min1.png");
  rotatedMinion = loadImage("min1other.png");
  introScreen = loadImage("introScreen.png");

  /////////////////////////////////////MUSIC///////////////////////////////////////////
  minim = new Minim(this);
  title = minim.loadFile("title.mp3", 2048);

  NoneShallLive = minim.loadFile("01 None Shall Live.mp3", 2048);
  Archangel = minim.loadFile("02 Archangel.mp3", 2048);
  Neverdark = minim.loadFile("04 Neverdark.mp3", 2048);
  United = minim.loadFile("04 United We Stand, Divided We Fall.mp3", 2048);
  RiseAbove = minim.loadFile("05 Rise Above.mp3", 2048);
  Starfall = minim.loadFile("05 Starfall.mp3", 2048);
  TheLastStand = minim.loadFile("06 The Last Stand.mp3", 2048);
  FireNation = minim.loadFile("07 Fire Nation.mp3", 2048);
  BlackBlade = minim.loadFile("08 Black Blade.mp3", 2048);
  Invincible = minim.loadFile("10 Invincible.mp3", 2048);
  Thousand = minim.loadFile("10 Strength of a Thousand Men.mp3", 2048);
  Bastion = minim.loadFile("11 Bastion.mp3", 2048);
  Stronger = minim.loadFile("11 Stronger Faster Braver.mp3", 2048);
  FlameHeart = minim.loadFile("12 Flameheart.mp3", 2048);
  Protectors = minim.loadFile("14 Protectors of the Earth.mp3", 2048);
  DragonRider = minim.loadFile("15 Dragon Rider.mp3", 2048);
  TitanDune = minim.loadFile("17 Titan Dune.mp3", 2048);
  ArmyOfJustice = minim.loadFile("19 Army of Justice.mp3", 2048);
  ToGlory = minim.loadFile("21 To Glory.mp3", 2048);
  Riders = minim.loadFile("23 Riders.mp3", 2048); 

  title.loop();


  /////////////////////////////////////////////////////////////////////////////////

  // Selectors
  iconBig = loadImage("selectorgood.png");
  iconSheet = loadImage("selectorsheet.png");
  // Resource Icons
  coin = loadImage("coin.png");
  logs = loadImage("logs.png");
  soldiers = loadImage("soldiers.png");
  metal = loadImage("metal.png");
  stone = loadImage("stone.png");
  towers = loadImage("towers.png");
  food = loadImage("food.png");
  // Bulding images.
  armoury = loadImage("sword.png");
  barracks = loadImage("barracks.png");
  castle = loadImage("castleicon.png");
  market = loadImage("market.png");
  quarry = loadImage("quarry.png");
  mill = loadImage("mill.png");
  refinery = loadImage("anvil.png");
  farm = loadImage("farm.png");
  // Store building images.
  buildingImages[1] = castle;
  buildingImages[2] = market;
  buildingImages[3] = mill;
  buildingImages[4] = farm;
  buildingImages[5] = quarry;
  buildingImages[6] = refinery;
  buildingImages[7] = barracks;
  buildingImages[8] = armoury;
  ////////////////////////////////NIGHT/////////////////////
  castleBoundWest = ((width/2) - (castlewidth/2)); 
  castleBoundEast = ((width/2) + (castlewidth/2));
  castleBoundNorth = ((height/2) - (castlewidth/2));
  castleBoundSouth = ((height/2) + (castlewidth/2));
  nightbackground = loadImage("night.png");
  bandit = loadImage("min1.png");
  skeleton = loadImage("skeleton.png");
  skeleton = skeleton.get(0, 0, 30, 35);
  werewolf = loadImage("werewolf.png");
  werewolf2 = werewolf.get(295, 0, 40, 40);
  werewolf = werewolf.get(0, 0, 40, 40);
  goblin = loadImage("goblin.png");
  goblin2 = goblin.get(0, 96, 30, 33);
  goblin = goblin.get(0, 0, 30, 33);
  ram = loadImage("ram.png"); 
  ram = ram.get(20, 20, 35, 35);
  greatKnight = loadImage("greatKnight.gif");
  greatKnight2 = greatKnight.get(380, 145, 60, 55);
  greatKnight = greatKnight.get(210, 0, 55, 70);
  ogre = loadImage("ogre.png");
  ogre2 = ogre.get(0, 234, 75, 77);
  ogre = ogre.get(0, 0, 75, 77);
  behemoth = loadImage("behemoth.png");
  behemoth2 = behemoth.get(0, 125, 95, 70);
  behemoth = behemoth.get(0, 220, 95, 70);
  drake = loadImage("drake.png");
  drake2 = drake.get(400, 400, 160, 175);
  drake = drake.get(400, 210, 160, 175);
  playerSheet = loadImage("Player_Knight.png");
  playerFrame = playerSheet.get(0, 0, 40, 40);
  gameOverScreen = loadImage("gameOverScreen.png");
  nightFade = loadImage("nightFade.png");
  bloodFade = loadImage("bloodFade.png");
  thunder = loadImage("thunder.png"); 
  soldiernorth = loadImage("soldiernorth.png");
  soldiernorth = soldiernorth.get(0, 0, 275, 35);
  soldiersouth = loadImage("soldiersouth.png");
  soldiersouth = soldiersouth.get(0, 0, 275, 35);
  soldiereast = loadImage("soldiereast.png");
  soldiereast = soldiereast.get(0, 0, 35, 275);
  soldierwest = loadImage("soldierwest.png");
  soldierwest = soldierwest.get(0, 0, 35, 275);
  // Extra Icons
  lightningIcon = loadImage("lightningwhite.png");
  magicIcon = loadImage("magicwhite.png");
  barBG = loadImage("barbg.png");
  healthBar = loadImage("health.png");
  lockIcon = loadImage("lock.png");
  clouds = loadImage("cloudsgood.png");
  //Enemies
  banditArray = new Bandit[numBandits];
  skeletonArray = new Skeleton[numSkeletons];
  werewolfArray = new Werewolf[numWerewolves];
  goblinArray = new Goblin[numGoblins];
  ramArray = new Ram[numRams];
  greatKnightArray = new GreatKnight[numGreatKnights];
  ogreArray = new Ogre[numOgres];
  behemothArray = new Behemoth[numBehemoths];
  drakeArray = new Drake[numDrakes];
  castlehealth = maxcastlehealth;
  spawnEnemies();
}

void draw() {
  if (onMenu == true) {
    drawMenuStart();
  }

  if (gameState == "Intro")
  {
    frameRate(60); 
    drawIntro();
  }

  if (gameState == "Day")
  {
    if (incomeRecieved == false) {
      resources[0] += goldIncome;
      resources[1] += woodIncome;
      resources[2] += stoneIncome;
      resources[3] += woodIncome;
      incomeRecieved = true;
    }

    frameRate(60);
    textFont(dayfont);
    textSize(20);
    drawDay();
    textFont(titlefont);
  }

  if (gameState == "NightFade")
  {
    fadeToNight();
  }

  if (gameState == "DayFade") {
    fadeToDay();
  }

  if (gameState == "Night")
  {    
    tint(255, 255);
    frameRate(60);
    drawNight();
    drawSoldiers();
    drawPlayerNight();
    drawEnemiesNight();
    fill(255);
    image(barBG, 150, 570);
    if (castlehealth > 0) {
      image(healthBar.get(0, 0, (int)(((float)castlehealth / (float)maxcastlehealth) * 500), 16), 152, 572);
    }
    image(magicIcon, 700, 15, 40, 40);
    image(lightningIcon, 700, 55, 40, 40);
    if (!thunderUnlocked) {
      image(lockIcon, 700, 55, 20, 20);
    }
    if (!stoneUnlocked) {
      image(lockIcon, 700, 15, 20, 20);
    }
    text(castlehealth, 385, 586);
    //text("Stone Burst", 700,50);
    text(stoneCDtimer/60, 750, 45);
    //text("Stone Strike", 700,100);
    text(thunderCDtimer/60, 750, 85);
    text("Gold: " + resources[0], 30, 100);
    textSize(30);
    text("X", 670, 45);
    text("Z", 670, 85);
    textSize(20);
    //text("Soldier Health", 690, 170);
    if (northSoldierHealth > 0 && northSoldiersUp == true) {
      text("N " + northSoldierHealth, 750, 200);
      //}else{
      //text("N " + 0, 750,200);
    }
    if (eastSoldierHealth > 0 && eastSoldiersUp == true) {
      text("E " + eastSoldierHealth, 752, 225);
      //}else{
      //text("E " + 0, 750,225);
    }
    if (southSoldierHealth > 0 && southSoldiersUp == true) {
      text("S " + southSoldierHealth, 752, 250);
      //}else{
      //text("S " + 0, 750,250);
    }
    if (westSoldierHealth > 0 && westSoldiersUp == true) {
      text("W " + westSoldierHealth, 750, 275);
      //}else{
      //text("W " + 0, 750,275);
    }
  }

  if (gameState == "BloodFade")
  {
    bloodFade();
  }

  if (gameState == "GameOver")
  {
    drawGameOver();
  }

  if (gameState == "Day" || gameState == "Night" || gameState == "NightFade" ||
    gameState == "BloodFade" || gameState == "GameOver") {
    playMusic();
  }
}

void mousePressed()
{
  //Stops the intro music  


  //opens a new player for sound effects


  //Start Game Clicked
  if (menuState == "Menu and Minions" && (mouseX >=150 && mouseX <=300) && (mouseY >=470 && mouseY <= 515) && onNight == false)
  {
    gameState = "Intro";
    //Andrew: Plays audio file from start to finish
    menuState = " ";
    player = minim.loadFile("sword.mp3", 2048);
    player.play(); 
    onMenu = false;
  }
  //Instructions Clicked
  if (menuState == "Menu and Minions" && (mouseX >= 350 && mouseX <= 500) && (mouseY >= 470 && mouseY <= 515))
  {
    menuState = "Instructions";
    //Andrew: Plays audio file from start to finish
    player = minim.loadFile("sword.mp3", 2048);
    player.play();
  }
  //Credits Clicked
  if (menuState == "Menu and Minions" && (mouseX >= 550 && mouseX <= 650) && (mouseY >= 470 && mouseY <= 515))
  {
    menuState = "Credits";
    //Andrew: Plays audio file from start to finish 
    player = minim.loadFile("sword.mp3", 2048);
    player.play();
  }
  //Credits Go Back Clicked
  if ((menuState == "Credits" || menuState == "Instructions") && (mouseX >= 360 && mouseX <= 450) && (mouseY >= 530 && mouseY <= 555))
  {
    menuState = "Menu";
    //Andrew: Plays audio file from start to finish 
    player = minim.loadFile("sword.mp3", 2048);
    player.play();
  }

  if (gameState == "Day")
  {
    if (!updateSquareID && squareID == buildID) { // Are we in build mode?
      for (int i = 0; i < menuOptions[squareID].length; i++) {
        if (i <= 1) {
          posNumPress = 0;
        }
        if (i == 2 || i == 3) {
          posNumPress = 1;
        }
        if (i == 4 || i == 5) {
          posNumPress = 2;
        }
        if (i == 6 || i == 7) {
          posNumPress = 3;
        }
        if ((mouseX >= (200 * posNumPress) + 12 && mouseX <= (200 * posNumPress) + 187) && (mouseY >= 475 && mouseY <= 515) && (i % 2 == 0)) {
          fireMenuEvent(i);
          updateSquareID = true;
        } else if ((mouseX >= (200 * posNumPress) + 12 && mouseX <= (200 * posNumPress) + 187) && (mouseY >= 525 && mouseY <= 565) && (i % 2 != 0)) {
          fireMenuEvent(i);
          updateSquareID = true;

          //loads a different sound effect
        }
      }
    } else {
      for (int i = 0; i < menuOptions[squareID].length; i++) {
        if ((mouseX >= (200 * i) + 12 && mouseX <= (200 * i) + 187) && (mouseY >=475 && mouseY <= 575)) {
          fireMenuEvent(i);
        }
      }
    }
  }
  if (gameState == "Night")
  {
    //Andrew: Plays audio file from start to finish
    //  player.setGain(-20);
    //player.play();

    attack();
    attacked = true;
  }
}

void keyPressed() {
  if (gameState == "Intro")  
  {
    if (key == ' ') {
      gameState = "Day"; 
      title.close();
    }
  }
  if (gameState== "Day")
  {
    if (key == 'w' && selectorY > 1) {
      selectorY -= 1;
    } else if (key == 's' && selectorY < 7) {
      selectorY += 1;
    } else if (key == 'a' && selectorX > 1) {
      selectorX -= 1;
    } else if (key == 'd' && selectorX < 7) {
      selectorX += 1;
    }
    updateSquareID = true;
  }
  if (gameState == "Night" && stoneCDtimer == 0)
  {
    if (key == 'z' && stoneUnlocked) {
      stoneUsed = true;
      stoneCDtimer = stoneCD;
    }
  }
  if (gameState == "Night" && thunderCDtimer == 0)
  {
    if (key == 'x' && thunderUnlocked) {
      thunderUsed = true;
      thunderCDtimer = thunderCD;
    }
  }
  if (gameState == "Night")
  {
    if (key == 'c' && eastSoldiersUp == false) {
      eastSoldiersUp = true;
      eastSoldierHealth = soldierHealth;
      eastUpdated = false;
      castleBoundEast += 40;
    } 
    if (key == 'v' && westSoldiersUp == false) {
      westSoldiersUp = true;
      westSoldierHealth = soldierHealth;
      westUpdated = false;
      castleBoundWest -= 40;
    } 
    if (key == 'b' && northSoldiersUp == false) {
      northSoldiersUp = true;
      northSoldierHealth = soldierHealth;
      northUpdated = false;
      castleBoundNorth -= 40;
    } 
    if (key == 'n' && southSoldiersUp == false) {
      southSoldiersUp = true;
      southSoldierHealth = soldierHealth;
      southUpdated = false;
      castleBoundSouth += 40;
    }
  }
}
//**************************************************************************************
//*********************************Menu Functions***************************************
//**************************************************************************************
void drawMenuStart()
{
  if (menuState == "Day") {
    image(one.get(0, 0, width, height), 0, 0);
    image(icon, menuPathX[menuPathStage]*tileSize - widthMenuOffset, menuPathY[menuPathStage]*tileSize - heightMenuOffset);
    menuPathStage++;
    if (menuPathStage == 7) {
      menuState = "Transition"; 
      frameRate(15);
    }
  } else if (menuState == "Transition") {
    image(one.get(0, 0, width, height), 0, 0);
    image(icon, menuPathX[menuPathStage-1]*tileSize - widthMenuOffset, menuPathY[menuPathStage-1]*tileSize - heightMenuOffset);
    image(two.get(0, 0, x, height), 0, 0);
    x += 12;
    if (x>800) {
      menuState = "Menu";
    }
  } else if (menuState == "Menu") {
    drawMenu();
  } else if (menuState == "Instructions") {
    drawInstructions();
  } else if (menuState == "Credits") {
    drawCredits();
  } else if (menuState == "Menu and Minions") {
    drawMenu();
    handleMinions();
  }
}

void handleMinions() {
  if (minionCount < 11) {
    float x = random(35, 765);
    Minion m = new Minion(x, 600, baseMinion);
    currentMinions[minionCount] = m;
    minionCount++;
  }
  for (int i = 0; i < minionCount; i++) {
    if (currentMinions[i].y > 450) {
      currentMinions[i].update();
    }
    if (currentMinions[i].x > 400) {
      currentMinions[i].img = rotatedMinion;
    } else {
      currentMinions[i].img = baseMinion;
    }
    image(currentMinions[i].img, currentMinions[i].x, currentMinions[i].y);
  }
}

void drawMenu()
{

  background(two);
  textSize(50);
  text("The Light of Dawn", 220, titlecounter);
  if (titlecounter <= 100)
  {
    titlecounter += 2;
  }
  textSize(30);
  text("Start Game", 160, startcounter);
  text("Instructions", 360, startcounter);
  text("Credits", 560, startcounter);
  if (startcounter >= 500)
  {
    startcounter -= 2;
  }
  if (startcounter <= 500 && titlecounter >= 100)
  {
    //Start Game hoverbox
    if ((mouseX >= 150 && mouseX <= 300) && (mouseY >= 470 && mouseY <= 515))
    {
      stroke(255);
      fill(255, 1);
      rect(150, 470, 150, 45, 7);
      fill(255);
      //line(160,505,250,505); line(160,505,160,480); line(160,480,250,480); line(250,480,250,505);
    } 
    //Instructions Hoverbox  
    if ((mouseX >= 350 && mouseX <= 500) && (mouseY >= 470 && mouseY <= 515))
    {
      stroke(255);
      stroke(255);
      fill(255, 1);
      rect(350, 470, 150, 45, 7);
      fill(255);
      //line(360,505,450,505); line(360,505,360,480); line(360,480,450,480); line(450,480,450,505);
    }  
    //Credits Hoverbox  
    if ((mouseX >= 550 && mouseX <= 650) && (mouseY >= 470 && mouseY <= 515))
    {
      stroke(255);
      //line(560,505,613,505); line(560,505,560,480); line(560,480,613,480); line(613,480,613,505);
      stroke(255);
      fill(255, 1);
      rect(550, 470, 100, 45, 7);
      fill(255);
    }  
    flame(); 
    menuState = "Menu and Minions";
  }
}

void drawCredits()
{
  frameRate(40);
  creditCount = (creditCount+1)%600; // 600-frame cycle
  image(creditNight, 0, 0);
  textSize(50);
  text("CREDITS", 285, 50);
  text("--Developers--", 270, 130);
  textSize(20);
  text("Go Back", 360, 540);
  textSize(30);
  for (int i = 0; i < 3; i++)
  {
    creditC = creditCount-300 + i*30; // counter, a little different for every letter
    creditX = width/2-100+creditC*creditC*creditC/10000+i*50; // quadratic, changes slowly in the middle
    creditY = height/2 + (i * 100); 
    stroke(255);
    text(creditNames[i], creditX, creditY);
  }
  if (creditX >= 900)
  {
    creditY = 0;
  }
  drawRedStar();
  frameRate(40);
}

void drawPlay()
{
  //Placeholder
  background(255);
  fill(0);
  text("PLACEHOLDER", 400, 300);
}

void drawIntro()
{
  image(introScreen, 0, 0);
  fill(0);
  textSize(20);
  text("Our kingdom has just completed our search for the Azarac, a mighty stone" + '\n' +
    "that possesses unimaginable powers. It has the power to do great good for" + '\n' +
    "this world, but also has the power to destroy it. Enemy kingdoms from across" + '\n' +
    "the land have learned of our aquisition of the Azarac, and they will stop at" + '\n' +
    "nothing to take it from us. Armies are marching to our doorstep. We must" + '\n' +
    "not let the Azarac fall into the wrong hands. We must bolster our defences" + '\n' +
    "and use the Azarac to drive off the enemy. A long assault is ahead of us.", 50, 50);

  text("Press Space to begin", 300, 500); 

  textSize(30);
  text("We will not fall!", 300, 400);
}

void drawInstructions()
{
  background(0);
  fill(255);
  textSize(20);
  text("Instructions:", 50, 50);
  text("During the day, manage your castle." + '\n' +
    "During the night, drive off hordes of enemies.", 50, 80);

  text("Day:" + '\n' +
    "Using the mouse and WASD keys, construct and upgrade buildings." + '\n' + 
    "Each building has a description when you select it. Some buildings" + '\n' +
    "provide resources, whereas some require you to spend resources to" + '\n' +
    "unlock new abilities or to upgrade your effectiveness." + '\n' +
    "There are 12 hours in the day phase. Performing actions uses up time." + '\n' +
    "Once time runs out, night begins.", 50, 130);
  text("Night:" + '\n' +
    "Use the mouse to move your character. Click the mouse to attack." + '\n' +
    "Enemies will approach your castle. If they reach the walls, they will" + '\n' +
    "start to damage it. Do not let this happen. If you have a group of soldiers" + '\n' +
    "up, the enemies will kill those first before advancing to the wall." + '\n' +
    "If you have unlocked the stone abilities, press Z to deal a magic burst that" + '\n' +
    "deals moderate damage to all enemies on screen. press X to deal a magic strike" + '\n' +
    "that deals high damage to a single enemy." + '\n' +
    "The game ends when your castle's health reaches 0.", 50, 290);

  text("Go Back", 360, 540);
}


void flame()
{
  frameRate(12);
  currentframe = flamesheet.get(xflame, yflame, 100, 100);
  image(currentframe, 145, 25);
  image(currentframe, 545, 25);
  xflame += 100;
  if (xflame == 400)
  {
    yflame += 100;
    xflame = 0;
  }
  if ((yflame == 400) && (xflame == 300))
  {
    xflame = 0;
    yflame = 0;
  }
}

void drawRedStar() {
  frameRate(2);
  currentframe = redStar.get(xStar, yStar, 65, 65);
  image(currentframe, 170, 75);
  image(currentframe, 545, 75);
  xStar += 65;
  if (xStar == 195)
  {
    yStar += 65;
    xStar = 0;
  }
  if ((yStar == 65) && (xStar == 130))
  {
    xStar = 0;
    yStar = 0;
  }
}

void playMusic()
{
  AudioPlayer[] songList = {NoneShallLive, Archangel, Neverdark, United, RiseAbove, Starfall, 
    TheLastStand, FireNation, BlackBlade, Invincible, Thousand, Bastion, 
    Stronger, FlameHeart, Protectors, DragonRider, TitanDune, ArmyOfJustice, 
    ToGlory, Riders};
  if (songPlaying == false)
  {
    index = round(random(1, 20));
    //songList[index].play();   
    songPlaying = true;
  }
  //if(songList[index].isPlaying() == false){songPlaying = false;}
}

//*************************************************************************************
//*************************************Day Functions***********************************
//*************************************************************************************

void drawDay()
{
  background(0);
  fill(255, 255, 255);
  rect(0, 0, 800, 600);
  fill(255, 255, 255);
  rect(0, 0, 550, 450); // Game Window
  rect(550, 0, 250, 450); // Resources
  rect(0, 450, 800, 150); // Menu Options
  // Grid.
  drawGrid();
  fill(255, 255, 255);
  image(iconSheet.get(iconPortion * 50, 0, 50, 50), (selectorX * 50) + 45, selectorY * 50);
  if (iconPortion == 7) {
    iconDirection = -1;
  }
  if (iconPortion == 1) {
    iconDirection = 1;
  }
  if (iconDelay == 4) {
    iconPortion += iconDirection; 
    iconDelay = 0;
  }
  iconDelay++;
  // Resource icons.
  image(coin, 570, 60, 40, 40);
  image(logs, 570, 110, 40, 40);
  image(stone, 570, 160, 40, 40);
  image(food, 570, 210, 40, 40);
  image(metal, 570, 260, 40, 40);
  image(soldiers, 570, 350, 40, 40);
  image(towers, 570, 400, 40, 40);
  // Resource text.
  fill(0, 0, 0);
  textSize(20);
  text("Gold", 625, 67, 100, 40);
  text("Wood", 625, 117, 100, 40);
  text("Stone", 625, 167, 100, 40);
  text("Food", 625, 217, 100, 40);
  text("Metal", 625, 267, 100, 40);
  text("- - - - - - - - - - - - - - - - -", 575, 310, 200, 40);
  text("Soldiers", 625, 357, 100, 40);
  text("Towers", 625, 407, 100, 40);
  // Resource count.
  text(resources[0]+"", 735, 67, 100, 40);
  text(resources[1]+"", 735, 117, 100, 40);
  text(resources[2]+"", 735, 167, 100, 40);
  text(resources[3]+"", 735, 217, 100, 40);
  text(resources[4]+"", 735, 267, 100, 40);
  text(resources[5]+"/4", 735, 357, 100, 40);
  text(resources[6]+"/4", 735, 407, 100, 40);
  fill(0, 0, 0);
  textSize(20);
  text("Rescources", 620, 40);
  text("Hours Remaining:", 140, 30);
  text(hours, 370, 30);
  text("Castle Health:", 140, 435);
  text(castlehealth, 370, 435);
  updateMenu();
  checkForHoverPopup();
  if (hours == 0)
  {
    gameState = "NightFade"; 
    onNight = true;
  }
}

void checkForHoverPopup() {
  if (!updateSquareID && squareID == buildID) {
    for (int i = 0; i < menuOptions[squareID].length; i++) {
      if (i <= 1) {
        posNumPress = 0;
      }
      if (i == 2 || i == 3) {
        posNumPress = 1;
      }
      if (i == 4 || i == 5) {
        posNumPress = 2;
      }
      if (i == 6 || i == 7) {
        posNumPress = 3;
      }
      if ((mouseX >= (200 * posNumPress) + 12 && mouseX <= (200 * posNumPress) + 187) && (mouseY >= 475 && mouseY <= 515) && (i % 2 == 0)) {
        showPopUp(i);
      } else if ((mouseX >= (200 * posNumPress) + 12 && mouseX <= (200 * posNumPress) + 187) && (mouseY >= 525 && mouseY <= 565) && (i % 2 != 0)) {
        showPopUp(i);
      }
    }
  }
}

void showPopUp(int id) {
  if (id < 7) {
    fill(255, 255, 255);
    rect(70, 70, 400, 290);
    textSize(36);
    textAlign(CENTER);
    fill(0);
    text(buildingNames[id], 70, 90, 400, 60);
    textSize(20);
    for (int i = 0; i < buildRequirements[id].length; i++) {
      text(buildRequirements[id][i], 70, 160 + (i * 30), 400, 60);
    }
    textSize(16);
    for (int i = 0; i < buildingDoes[id].length; i++) {
      text(buildingDoes[id][i], 70, 270 + (i * 30), 400, 60);
    }
    textAlign(BASELINE);
  }
}

int getNumberOf(int buildingID) {
  int total = 0;
  for (int i = 0; i < grid.length; i++) {
    for (int j = 0; j < grid[i].length; j++) {
      if (grid[i][j] == buildingID) {
        total++;
      }
    }
  }
  return total;
}

void drawGrid() {
  strokeWeight(8);
  rect(95, 50, 350, 350);
  noStroke();
  for (int i = 1; i < 8; i++) {
    for (int j = 1; j < 8; j++) {
      if (buildingImages[grid[i-1][j-1]] == null) {
        fill(255, 255, 255);
        rect((i * 50) + 45, (j * 50), 50, 50);
      } else {
        image(buildingImages[grid[i-1][j-1]], (i * 50) + 45, (j * 50), 50, 50);
        if (upgradeData[i-1][j-1] == 1) {
          fill(0, 255, 0);
          textSize(36);
          text("+", (i * 50) + 56, (j * 50) + 36);
          fill(255);
        }
      }
    }
  }
  strokeWeight(1);
  stroke(0);
}

void updateMenu() {
  if (updateSquareID) {
    squareID = grid[selectorX - 1][selectorY - 1];
  }
  textSize(20);
  if (!updateSquareID && squareID == buildID) { // Are we in build mode?
    for (int i = 0; i < menuOptions[squareID].length; i++) {
      fill(255, 255, 255);
      if (i <= 1) {
        posNum = 0;
      }
      if (i == 2 || i == 3) {
        posNum = 1;
      }
      if (i == 4 || i == 5) {
        posNum = 2;
      }
      if (i == 6 || i == 7) {
        posNum = 3;
      }
      if (i % 2 == 0) {
        rect((200 * posNum) + 12, 475, 175, 40);
        fill(0);
        text(menuOptions[squareID][i], (200 * posNum) + 20, 500);
      } else {
        rect((200 * posNum) + 12, 525, 175, 40);
        fill(0);
        text(menuOptions[squareID][i], (200 * posNum) + 20, 550);
      }
    }
  } else {
    for (int i = 0; i < menuOptions[squareID].length; i++) {
      fill(255, 255, 255);
      rect((200 * i) + 12, 475, 175, 100);
      fill(0);
      text(menuOptions[squareID][i], (200 * i) + 20, 500);
      addImplications(menuOptions[squareID][i], i);
    }
  }
}

void addImplications(String buttonType, int pos) {
  textSize(14);
  if (buttonType == "Refine") {
    text("- 10 Stone", (200 * pos) + 20, 525);
    text("+ 1 Metal", (200 * pos) + 20, 550);
  } else if (buttonType == "Upgrade") {
    if (squareID == 2) { // Market
      text("- 100 Gold", (200 * pos) + 20, 525);
      text("- 150 Wood", (200 * pos) + 20, 550);
    } else if (squareID == 3) {
      text("- 150 Gold", (200 * pos) + 20, 525);
      text("- 100 Wood", (200 * pos) + 20, 550);
    } else if (squareID == 4) {
      text("- 100 Gold", (200 * pos) + 20, 525);
      text("- 150 Wood", (200 * pos) + 20, 550);
    } else if (squareID == 5) {
      text("- 50 Gold", (200 * pos) + 20, 525);
      text("- 200 Wood", (200 * pos) + 20, 545);
      text("- 100 Stone", (200 * pos) + 20, 565);
    }
  } else if (buttonType == "Destroy") {
    text("Clear space", (200 * pos) + 20, 525);
  } else if (buttonType == "Buy soldiers") {
    text("- 50 Food", (200 * pos) + 20, 525);
    text("+ 1 Soldier", (200 * pos) + 20, 550);
  } else if (buttonType == "Sleep") {
    text("End Day", (200 * pos) + 20, 525);
  } else if (buttonType == "Repair") {
    text("Repair walls", (200 * pos) + 20, 525);
    text("Increase health", (200 * pos) + 20, 545);
  } else if (buttonType == "Build") {
    text("Build a new", (200 * pos) + 20, 525);
    text("Building", (200 * pos) + 20, 545);
  } else if (buttonType == "Work market") {
    text("- 1 Hour", (200 * pos) + 20, 525);
    text("+ " + 5 * getNumberOf(2) + " Gold", (200 * pos) + 20, 550);
  } else if (buttonType == "Work mill") {
    text("- 1 Hour", (200 * pos) + 20, 525);
    text("+ " + 5 * getNumberOf(3) + " Wood", (200 * pos) + 20, 550);
  } else if (buttonType == "Work farm") {
    text("- 1 Hour", (200 * pos) + 20, 525);
    text("+ " + 5 * getNumberOf(4) + " Food", (200 * pos) + 20, 550);
  } else if (buttonType == "Work quarry") {
    text("- 1 Hour", (200 * pos) + 20, 525);
    text("+ " + 5 * getNumberOf(5) + " Stone", (200 * pos) + 20, 550);
  } else if (buttonType == "Repair 50") {
    text("- 1 Hour", (200 * pos) + 20, 525);
    text("- 10 Stone", (200 * pos) + 20, 545);
    text("+ 50 Castle health", (200 * pos) + 20, 565);
  } else if (buttonType == "Repair 100") {
    text("- 2 Hour", (200 * pos) + 20, 525);
    text("- 20 Stone", (200 * pos) + 20, 545);
    text("+ 100 Castle health", (200 * pos) + 20, 565);
  } else if (buttonType == "Repair 500") {
    text("- 3 Hour", (200 * pos) + 20, 525);
    text("- 50 Stone", (200 * pos) + 20, 545);
    text("+ 500 Castle health", (200 * pos) + 20, 565);
  } else if (buttonType == "Stone Burst") {
    text("- 200 Gold", (200 * pos) + 20, 525);
    text("Shoot mana wave", (200 * pos) + 20, 550);
  } else if (buttonType == "Stone Strike") {
    text("- 300 Gold", (200 * pos) + 20, 525);
    text("Shoot lightning", (200 * pos) + 20, 550);
  } else if (buttonType == "Weapons") {
    text("Increase damage", (200 * pos) + 20, 525);
  } else if (buttonType == "Dagger") {
    text("- 50 Gold", (200 * pos) + 20, 525);
    text("+ 1 damage", (200 * pos) + 20, 545);
    if (dagger) {
      text("SOLD OUT", (200 * pos) + 20, 565);
    }
  } else if (buttonType == "Hammer") {
    text("- 100 Gold", (200 * pos) + 20, 525);
    text("+ 1 damage", (200 * pos) + 20, 545);
    if (hammer) {
      text("SOLD OUT", (200 * pos) + 20, 565);
    }
  } else if (buttonType == "War Axe") {
    text("- 150 Gold", (200 * pos) + 20, 525);
    text("+ 2 damage", (200 * pos) + 20, 545);
    if (axe) {
      text("SOLD OUT", (200 * pos) + 20, 565);
    }
  } else if (buttonType == "Longsword") {
    text("- 200 Gold", (200 * pos) + 20, 525);
    text("+ 3 damage", (200 * pos) + 20, 545);
    if (sword) {
      text("SOLD OUT", (200 * pos) + 20, 565);
    }
  }
  textSize(20);
}

void fireMenuEvent(int i) {
  // BASE MENU OPTIONS
  if (menuOptions[squareID][i] == "Build") {
    updateSquareID = false;
    squareID = buildID; // Show repair submenu.
  } else if (menuOptions[squareID][i] == "Repair") {
    updateSquareID = false;
    squareID = 10; // Show repair submenu.
  } else if (menuOptions[squareID][i] == "Sleep") {
    // When sleep is clicked...
    gameState = "NightFade";
    onNight = true;
  } else if (menuOptions[squareID][i] == "Back") {
    updateSquareID = true;
  } else if (menuOptions[squareID][i] == "Upgrade") {
    // upgrade

    if (grid[selectorX - 1][selectorY - 1] == 2 && resources[1] >= 150 && resources[0] >= 100 && upgradeData[selectorX - 1][selectorY - 1] != 1) {
      upgradeData[selectorX - 1][selectorY - 1] = 1;
      resources[1] -= 150;
      resources[0] -= 100; 
      goldIncome += 10;
    }
    if (grid[selectorX - 1][selectorY - 1] == 3 && resources[0] >= 150 && resources[1] >= 100 && upgradeData[selectorX - 1][selectorY - 1] != 1) {
      upgradeData[selectorX - 1][selectorY - 1] = 1;
      resources[1] -= 100;
      resources[0] -= 150; 
      woodIncome += 10;
    }
    if (grid[selectorX - 1][selectorY - 1] == 4 && resources[1] >= 150 && resources[0] >= 100 && upgradeData[selectorX - 1][selectorY - 1] != 1) {
      upgradeData[selectorX - 1][selectorY - 1] = 1;
      resources[1] -= 150;
      resources[0] -= 100; 
      foodIncome += 10;
    }
    if (grid[selectorX - 1][selectorY - 1] == 5 && resources[1] >= 200 && resources[0] >= 50 && resources[2] >= 100 && upgradeData[selectorX - 1][selectorY - 1] != 1) {
      upgradeData[selectorX - 1][selectorY - 1] = 1;
      resources[1] -= 200;
      resources[2] -= 100;
      resources[0] -= 50; 
      stoneIncome += 10;
    }
  } else if (menuOptions[squareID][i] == "Destroy") {
    grid[selectorX - 1][selectorY - 1] = 0;
  } else if (menuOptions[squareID][i] == "Refine") {
    if (resources[2] >= 10) {
      resources[2] -= 10; // Remove 10 stone.
      resources[4] += 1;  // Add 1 metal.
    }
  } else if (menuOptions[squareID][i] == "Buy soldiers") {
    if (resources[3] >= 50 && resources[5] < 4) {
      resources[3] -= 50; // Remove 50 food.
      resources[5] += 1;  // Add 1 soldier.
      putUpRightSoldiers();
    }
  } else if (menuOptions[squareID][i] == "Armour") {
  } else if (menuOptions[squareID][i] == "Work market") {
    if (hours >= 1) {
      hours--;
      resources[0] += 5 * getNumberOf(2);
    }
  } else if (menuOptions[squareID][i] == "Work mill") {
    if (hours >= 1) {
      hours--;
      resources[1] += 5 * getNumberOf(3);
    }
  } else if (menuOptions[squareID][i] == "Work farm") {
    if (hours >= 1) {
      hours--;
      resources[3] += 5 * getNumberOf(4);
    }
  } else if (menuOptions[squareID][i] == "Work quarry") {
    if (hours >= 1) {
      hours--;
      resources[2] += 5 * getNumberOf(5);
    }
  } else if (menuOptions[squareID][i] == "Dagger") {
    if (resources[0] >= 50 && !dagger) {
      resources[0] -= 50;
      dagger = true;
      playerDamage += 1;
      player = minim.loadFile("buy.mp3", 2048);
      player.play();
    }
  } else if (menuOptions[squareID][i] == "Hammer") {
    if (resources[0] >= 100 && !hammer) {
      resources[0] -= 100;
      hammer = true;
      playerDamage += 1;
      player = minim.loadFile("buy.mp3", 2048);
      player.play();
    }
  } else if (menuOptions[squareID][i] == "War Axe") {
    if (resources[0] >= 150 && !axe) {
      resources[0] -= 150;
      axe = true;
      playerDamage += 2;
      player = minim.loadFile("buy.mp3", 2048);
      player.play();
    }
  } else if (menuOptions[squareID][i] == "Longsword") {
    if (resources[0] >= 50 && !sword) {
      resources[0] -= 50;
      sword = true;
      playerDamage += 3;
      player = minim.loadFile("buy.mp3", 2048);
      player.play();
    } 
    // BUILD MENU OPTIONS
  } else if (menuOptions[squareID][i] == "Repair 50") {
    if (hours >= 1 && resources[2] >= 10) {
      hours--;
      resources[2] -= 10;
      if (maxcastlehealth - castlehealth <= 50) {
        castlehealth = maxcastlehealth;
      } else {
        castlehealth += 50;
      }
      player = minim.loadFile("buy.mp3", 2048);
      player.play();
    }
  } else if (menuOptions[squareID][i] == "Repair 100") {
    if (hours >= 2 && resources[2] >= 20) {
      hours -= 2;
      resources[2] -= 20;
      if (maxcastlehealth - castlehealth <= 100) {
        castlehealth = maxcastlehealth;
      } else {
        castlehealth += 100;
      }
      player = minim.loadFile("buy.mp3", 2048);
      player.play();
    }
  } else if (menuOptions[squareID][i] == "Repair 500") {
    if (hours >= 3 && resources[2] >= 50) {
      hours -= 3;
      resources[2] -= 50;
      if (maxcastlehealth - castlehealth <= 500) {
        castlehealth = maxcastlehealth;
      } else {
        castlehealth += 500;
      }
      player = minim.loadFile("buy.mp3", 2048);
      player.play();
    }
  } else if (menuOptions[squareID][i] == "Stone Burst") {
    if (resources[0] >= 200) {
      resources[0] -= 200;
      stoneUnlocked = true;
      player = minim.loadFile("buy.mp3", 2048);
      player.play();
    }
  } else if (menuOptions[squareID][i] == "Stone Strike") {
    if (resources[0] >= 300) {
      thunderUnlocked = true;
      resources[0] -= 300;
      player = minim.loadFile("buy.mp3", 2048);
      player.play();
    }
  } else if (menuOptions[squareID][i] == "Weapons") {
    updateSquareID = false;
    squareID = 12; // Show repair submenu.
  } else if (menuOptions[squareID][i] == "Market") {
    if (resources[0] >= 50 && resources[1] >= 10 && hours >= 2) {
      resources[0] -= 50;
      resources[1] -= 10;
      hours -= 2;
      grid[selectorX - 1][selectorY - 1] = 2;
      goldIncome += 5;
      player = minim.loadFile("buy.mp3", 2048);
      player.play();
    }
  } else if (menuOptions[squareID][i] == "Farm") {
    if (resources[0] >= 100 && resources[1] >= 10 && hours >= 3) {
      resources[0] -= 100;
      resources[1] -= 10;
      hours -= 3;
      grid[selectorX - 1][selectorY - 1] = 4;
      foodIncome += 5;
      player = minim.loadFile("buy.mp3", 2048);
      player.play();
    }
  } else if (menuOptions[squareID][i] == "Quarry") {
    if (resources[0] >= 100 && resources[2] >= 20 && hours >= 3) {
      resources[0] -= 100;
      resources[2] -= 20;
      hours -= 3;
      grid[selectorX - 1][selectorY - 1] = 5;
      stoneIncome += 5;
      player = minim.loadFile("buy.mp3", 2048);
      player.play();
    }
  } else if (menuOptions[squareID][i] == "Refinery") {
    if (resources[0] >= 200 && resources[2] >= 20 && hours >= 4) {
      resources[0] -= 200;
      resources[2] -= 20;
      hours -= 4;
      grid[selectorX - 1][selectorY - 1] = 6;
      player = minim.loadFile("buy.mp3", 2048);
      player.play();
    }
  } else if (menuOptions[squareID][i] == "Barracks") {
    if (resources[0] >= 250 && resources[4] >= 10 && hours >= 4) {
      resources[0] -= 250;
      resources[4] -= 10;
      hours -= 4;
      grid[selectorX - 1][selectorY - 1] = 7;
      player = minim.loadFile("buy.mp3", 2048);
      player.play();
    }
  } else if (menuOptions[squareID][i] == "Armoury") {
    if (resources[0] >= 300 && resources[4] >= 20 && hours >= 4) {
      resources[0] -= 300;
      resources[4] -= 20;
      hours -= 4;
      grid[selectorX - 1][selectorY - 1] = 8;
      player = minim.loadFile("buy.mp3", 2048);
      player.play();
    }
  } else if (menuOptions[squareID][i] == "Mill") {
    if (resources[0] >= 50 && resources[1] >= 20 && hours >= 3) {
      resources[0] -= 50;
      resources[4] -= 20;
      hours -= 3;
      grid[selectorX - 1][selectorY - 1] = 3;
      woodIncome += 5;
      player = minim.loadFile("buy.mp3", 2048);
      player.play();
    }
  }
}

void putUpRightSoldiers() {
  boolean soldierValues[] = {northSoldiersUp, southSoldiersUp, eastSoldiersUp, westSoldiersUp};
  for (int i = 0; i < 4; i++) {
    if (!soldierValues[i]) {
      if (i == 0) {
        northSoldiersUp = true;
        northSoldierHealth = soldierHealth;
        northUpdated = false;
        castleBoundNorth -= 40;
        break;
      } else if (i == 1) {
        southSoldiersUp = true;
        southSoldierHealth = soldierHealth;
        southUpdated = false;
        castleBoundSouth += 40;
        break;
      } else if (i == 2) {
        eastSoldiersUp = true;
        eastSoldierHealth = soldierHealth;
        eastUpdated = false;
        castleBoundEast += 40;
        break;
      } else if (i == 3) {
        westSoldiersUp = true;
        westSoldierHealth = soldierHealth;
        westUpdated = false;
        castleBoundWest -= 40;
        break;
      }
    }
  }
}

//***************************************************************************************
//***********************************Night Functions*************************************
//***************************************************************************************

void drawNight()
{
  background(0);
  fill(255);
  rect((width/2) - castlewidth/2, (height/2) - castlewidth/2, castlewidth, castlewidth);
  image(nightbackground, 0, 0);

  fill(255);

  textSize(20);

  text("Night: ", 25, 40);
  text(nightCounter, 75, 40);
  text("Wave: ", 25, 70);
  text(waveCounter + 1, 75, 70);
  if (stoneCDtimer > 0) {
    stoneCDtimer --;
  } // Stone burst cooldown
  if (thunderCDtimer >0) {
    thunderCDtimer --;
  } // Stone thunder strike cooldown
  if (numEnemies == 0 && onNight == true && stoneUsed == false)
  {
    //End the night
    gameState = "DayFade"; // NOTE: CHANGED HERE.
    hours = 12;
    nightCounter ++;

    //Prepare Next wave
    selectEnemies();


    banditArray = new Bandit[numBandits];
    skeletonArray = new Skeleton[numSkeletons];
    werewolfArray = new Werewolf[numWerewolves];
    goblinArray = new Goblin[numGoblins];
    ramArray = new Ram[numRams];
    greatKnightArray = new GreatKnight[numGreatKnights];
    ogreArray = new Ogre[numOgres];
    behemothArray = new Behemoth[numBehemoths];
    drakeArray = new Drake[numDrakes];
    spawnEnemies();


    waveCounter = 0;
    onNight = false;
  }
  //Game over
  if (castlehealth <= 0)
  {
    gameState = "BloodFade";
  }

  if (stoneUsed == true) {
    stoneBurst();
    if (stoneTimer == 750) {
      stoneUsed = false;
      stoneTimer = 0;
    }
  }
}

void drawPlayerNight()
{

  fill(0, 0, 200);
  playerNightX = mouseX;
  playerNightY = mouseY;


  if (mouseX >= (castleBoundWest + 10) && mouseX <= (castleBoundEast - 10)
    && mouseY >= (castleBoundNorth + 10) && mouseY <= (castleBoundSouth - 10))
  {
  } else {
    drawPlayer();
  }
}

void drawPlayer()
{
  int numFrames; 
  int up = 0, down = 1;

  numFrames = frameCount; 

  if (previousMoveNight > mouseY) {
    playerState = up;
  } else if (previousMoveNight < mouseY) {
    playerState = down;
  }

  if (playerState == down)
  {
    yPlayer = 0;
    playerFrame = playerSheet.get(xPlayer, yPlayer, 38, 38);
    image(playerFrame, mouseX - 20, mouseY - 20);
    if (numFrames % 10 == 0) { 
      xPlayer += 38;
    }
    if (xPlayer == 114) { 
      xPlayer = 0;
    }
  }
  if (playerState == up)
  {
    yPlayer = 118;
    playerFrame = playerSheet.get(xPlayer, yPlayer, 38, 40);
    image(playerFrame, mouseX - 20, mouseY - 20);
    if (numFrames % 10 == 0) {
      xPlayer += 38;
    }
    if (xPlayer == 114) {
      xPlayer = 0;
    }
  }


  previousMoveNight = mouseY;
}

void drawEnemiesNight()
{
  if (gameState != "DayFade")
  {

    //Bandits
    for (int i = 0; i < numBandits; i++)
    {
      banditArray[i].display();
      banditArray[i].update();
      banditArray[i].checkHit();
      banditArray[i].damageCastle();  
      if (banditArray[i].checkHealth() == true)
      {
        int dropChance = round(random(0, 1));
        if (dropChance == 1) {
          resources[0] += 1;
        }
        banditArray[i] = banditArray[numBandits - 1]; 
        numBandits--;
      }
    }
    //Skeletons
    for (int i = 0; i < numSkeletons; i++)
    {
      skeletonArray[i].display();
      skeletonArray[i].update();
      skeletonArray[i].checkHit();
      skeletonArray[i].damageCastle();
      if (skeletonArray[i].checkHealth() == true)
      {
        int dropChance = round(random(0, 1));
        if (dropChance == 1) {
          resources[0] += 2;
        }
        skeletonArray[i] = skeletonArray[numSkeletons - 1]; 
        numSkeletons--;
      }
    }
    //Werewolves
    for (int i = 0; i < numWerewolves; i++)
    {
      werewolfArray[i].display();
      werewolfArray[i].update();
      werewolfArray[i].checkHit();
      werewolfArray[i].damageCastle();
      if (werewolfArray[i].checkHealth() == true)
      {
        int dropChance = round(random(0, 2));
        if (dropChance == 1) {
          resources[0] += 2;
        }
        werewolfArray[i] = werewolfArray[numWerewolves - 1]; 
        numWerewolves--;
      }
    }
    //Goblins
    for (int i = 0; i < numGoblins; i++)
    {
      goblinArray[i].display();
      goblinArray[i].update();
      goblinArray[i].checkHit();
      goblinArray[i].damageCastle();
      if (goblinArray[i].checkHealth() == true)
      {
        int dropChance = round(random(0, 5));
        if (dropChance == 1) {
          resources[0] += 1;
        }
        goblinArray[i] = goblinArray[numGoblins - 1]; 
        numGoblins--;
      }
    }
    //Rams
    for (int i = 0; i < numRams; i++)
    {
      ramArray[i].display();
      ramArray[i].update();
      ramArray[i].checkHit();
      ramArray[i].damageCastle();
      if (ramArray[i].checkHealth() == true)
      {
        int dropChance = round(random(0, 4));
        if (dropChance == 1) {
          resources[0] += 5;
        }
        ramArray[i] = ramArray[numRams - 1]; 
        numRams--;
      }
    }
    //Great Knights 
    for (int i = 0; i < numGreatKnights; i++)
    {
      greatKnightArray[i].display();
      greatKnightArray[i].update();
      greatKnightArray[i].checkHit();
      greatKnightArray[i].damageCastle();
      if (greatKnightArray[i].checkHealth() == true)
      {
        int dropChance = round(random(0, 5));
        if (dropChance == 1) {
          resources[0] += 4;
        }
        greatKnightArray[i] = greatKnightArray[numGreatKnights - 1]; 
        numGreatKnights--;
      }
    }
    //Ogres
    for (int i = 0; i < numOgres; i++)
    {
      ogreArray[i].display();
      ogreArray[i].update();
      ogreArray[i].checkHit();
      ogreArray[i].damageCastle();
      if (ogreArray[i].checkHealth() == true)
      {
        int dropChance = round(random(0, 10));
        if (dropChance == 1) {
          resources[0] += 10;
        }
        ogreArray[i] = ogreArray[numOgres - 1]; 
        numOgres--;
      }
    }
    //Behemoths
    for (int i = 0; i < numBehemoths; i++)
    {
      behemothArray[i].display();
      behemothArray[i].update();
      behemothArray[i].checkHit();
      behemothArray[i].damageCastle();
      if (behemothArray[i].checkHealth() == true)
      {
        int dropChance = round(random(0, 5));
        if (dropChance == 1) {
          resources[0] += 5;
        }
        behemothArray[i] = behemothArray[numBehemoths - 1]; 
        numBehemoths--;
      }
    }
    //Drakes
    for (int i = 0; i < numDrakes; i++)
    {
      drakeArray[i].display();
      drakeArray[i].update();
      drakeArray[i].checkHit();
      drakeArray[i].damageCastle();
      if (drakeArray[i].checkHealth() == true)
      {
        int dropChance = round(random(0, 20));
        if (dropChance == 1) {
          resources[0] += 50;
        }
        drakeArray[i] = drakeArray[numDrakes - 1]; 
        numDrakes--;
      }
    }
    numEnemies = numBandits + numSkeletons + numWerewolves + numGoblins + numRams 
      + numGreatKnights + numOgres + numBehemoths + numDrakes;
  }
  if (numEnemies == 0 && waveCounter < 2 && stoneUsed == false)
  {
    selectEnemies();
    banditArray = new Bandit[numBandits];
    skeletonArray = new Skeleton[numSkeletons];
    werewolfArray = new Werewolf[numWerewolves];
    goblinArray = new Goblin[numGoblins];
    ramArray = new Ram[numRams];
    greatKnightArray = new GreatKnight[numGreatKnights];
    ogreArray = new Ogre[numOgres];
    behemothArray = new Behemoth[numBehemoths];
    drakeArray = new Drake[numDrakes];

    spawnEnemies();

    waveCounter++;
  }
  numEnemies = numBandits + numSkeletons + numWerewolves + numGoblins + numRams
    + numGreatKnights + numOgres + numBehemoths + numDrakes;
}

PVector spawnLocation()
{
  int roll = int(random(1, 5));
  PVector spawn = new PVector(0, 0);
  if (roll == 1) {
    spawn.x = random(width); 
    spawn.y = 0;
  } else if (roll == 2) {
    spawn.x = random(width); 
    spawn.y = height;
  } else if (roll == 3) {
    spawn.x = 0; 
    spawn.y = random(height);
  } else if (roll == 4) {
    spawn.x = width; 
    spawn.y = random(height);
  }

  return spawn;
}

void spawnEnemies()
{
  for (int i = 0; i < numBandits; i++)
  {
    banditArray[i] = new Bandit(spawnLocation());
  }

  for (int i = 0; i < numSkeletons; i++)
  {
    skeletonArray[i] = new Skeleton(spawnLocation());
  }

  for (int i = 0; i < numWerewolves; i++)
  {
    werewolfArray[i] = new Werewolf(spawnLocation());
  }

  for (int i = 0; i < numGoblins; i++)
  {
    goblinArray[i] = new Goblin(spawnLocation());
  }

  for (int i = 0; i < numRams; i++)
  {
    ramArray[i] = new Ram(spawnLocation());
  }

  for (int i = 0; i < numGreatKnights; i++)
  {
    greatKnightArray[i] = new GreatKnight(spawnLocation());
  }
  for (int i = 0; i < numOgres; i++)
  {
    ogreArray[i] = new Ogre(spawnLocation());
  }

  for (int i = 0; i < numBehemoths; i++)
  {
    behemothArray[i] = new Behemoth(spawnLocation());
  }

  for (int i = 0; i < numDrakes; i++)
  {
    drakeArray[i] = new Drake(spawnLocation());
  }
}

void selectEnemies()
{
  if (nightCounter < 3) {
    numBandits = waveCounter + (nightCounter * round(random(1, 2)));
  }
  if (nightCounter >= 3) {
    numSkeletons = nightCounter + waveCounter - round(random(0, 3)); 
    numBandits = nightCounter + round(random(0, waveCounter));
  }
  if (nightCounter >= 5) {
    numWerewolves = (waveCounter + 1) * round(random(0, 3));
  }
  if (nightCounter >= 7) {
    numGoblins = (round(random(0, 1)) * (nightCounter + waveCounter)) + round(random(0, 5));
  }
  if (nightCounter >= 10) {
    numRams = waveCounter + round(random(0, 2)) -  round(random(0, waveCounter));
  }
  if (nightCounter >= 15) {
    numGreatKnights =  waveCounter + round(random(0, 2));
  }
  if (nightCounter >= 20) {
    numOgres = nightCounter - round(random(10, 18));
  }
  if (nightCounter >= 25) {
    numBehemoths = round(random(0, 3)) + round(random(0, waveCounter));
  }
  if (nightCounter >= 30) {
    numDrakes = round(random(0, 2));
  }
}

void attack()
{
  fill(255);
  ellipse(mouseX, mouseY, 40, 10);
  ellipse(mouseX, mouseY, 10, 40);
}

void stoneBurst()
{
  noStroke();
  fill(0, 0, 70, 126);
  ellipse(width/2, height/2, stoneTimer, stoneTimer);
  stoneTimer += 10;
}

void stoneStrike(float x, float y, Bandit z)
{
  thunderFrame = thunder.get(xThunder, yThunder, 192, 192);
  image(thunderFrame, x, y);
  xThunder += 192;
  if (xThunder == 960)
  {
    yThunder += 192;
    xThunder = 0;
  }
  if ((yThunder >= 768))
  {
    xThunder = 0;
    yThunder = 0;
    z.displayThunder = false;
    z.health -= thunderDamage;
  }
}

void drawSoldiers()
{
  if (eastSoldierHealth <= 0 && eastUpdated == false)
  {
    eastSoldiersUp = false; 
    castleBoundEast -= 40;
    eastUpdated = true;
  }
  if (westSoldierHealth <= 0 && westUpdated == false)
  {
    westSoldiersUp = false;
    castleBoundWest += 40;
    westUpdated = true;
  }
  if (northSoldierHealth <= 0 && northUpdated == false)
  {
    northSoldiersUp = false; 
    castleBoundNorth += 40;
    northUpdated = true;
  }
  if (southSoldierHealth <= 0 && southUpdated == false)
  {
    southSoldiersUp = false; 
    castleBoundSouth -= 40;
    southUpdated = true;
  }

  if (eastSoldiersUp == true) {
    image(soldiereast, castleBoundEast - 25, 162);
  } 
  if (westSoldiersUp == true) {
    image(soldierwest, castleBoundWest - 20, 162);
  } 
  if (northSoldiersUp == true) {
    image(soldiernorth, 262, castleBoundNorth - 10);
  } 
  if (southSoldiersUp == true) {
    image(soldiersouth, 262, castleBoundSouth - 25);
  }
}

void bloodFade()
{
  tint(255, 20);
  image(bloodFade, 0, bloodFadeTimer);

  if (bloodFadeTimer < 600) {
    bloodFadeTimer += 3;
  }

  if (bloodFadeTimer == 0) {
    gameState = "GameOver";
  }
}


void drawGameOver()
{
  image(gameOverScreen, 0, 0);
  fill(255);
  textSize(50);
  text("The Kingdom has fallen", 180, 50);
  text("You survived " + (nightCounter - 1) + " nights", 190, 530);
}

void fadeToNight()
{
  tint(255, 20);
  image(nightFade, fadeTimer, 0);

  if (fadeTimer < 400) {
    fadeTimer += 5;
  }
  if (fadeTimer >= -400)
  {
    image(nightFade, fadeTimer - 400, 0);
  }
  if (fadeTimer >= 0)
  {
    textSize(30);
    fill(255);
    text("Night " + nightCounter, 370, 300);
  }
  if (fadeTimer == 400) {
    fadeTimer = -800; 
    gameState = "Night";
  }
}

void fadeToDay()
{
  tint(255, 10);
  image(clouds, fadeTimer, 0);

  if (fadeTimer < 400) {
    fadeTimer += 5;
  }
  if (fadeTimer >= -400)
  {
    image(clouds, fadeTimer - 400, 0);
  }
  if (fadeTimer >= 0)
  {
    textSize(30);
    fill(0, 0, 0);
    text("Day " + nightCounter, 370, 300);
  }
  if (fadeTimer == 400) {
    fadeTimer = -800; 
    gameState = "Day";
    incomeRecieved = false;
  }
  tint(255, 255);
}

void stop()
{
  player.close();
  minim.stop();
  super.stop();
}