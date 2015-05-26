final int BACKGROUND_COLOR = 10;
final int WALL_COLOR = 0xCCCCCC;
final int PACMAN_SPEED = 2;
final int GHOST_SPEED = 1;

boolean running = false;
boolean paused = false;

int xPos;
int yPos;
int xVel = PACMAN_SPEED;
int yVel = 0;

float startT, stopT;

void setup() {
  size( 640, 480 );
  background( BACKGROUND_COLOR );
  fill( 200 );
  noStroke();
  rect( 210, 192, 210, 96);
  textSize( 32 );
  fill( 255, 0, 0 );
  text( "START", 260, 250 );
}

void mouseClicked() {
  if( !running ) {
    startNew();
  }
}

void keyPressed() {
  if( !running && key != ' ' ) return;
  if( !running && key == ' ' ) {
    startNew();
    return;
  }
  if( key == ' ' || key == 'p' || key == 'P' ) {
    if( paused ) {
      paused = false;
    }
    else {
      paused = true;
      textSize( 96 );
      fill( 255, 0, 0 );
      text( "PAUSED", 140, 150 );
    }
    return;
  } else if( keyCode == UP ) {
    xVel = 0;
    yVel = -PACMAN_SPEED;
    return;
  } else if( keyCode == DOWN ) {
    xVel = 0;
    yVel = PACMAN_SPEED;
    return;
  } else if( keyCode == RIGHT ) {
    xVel = PACMAN_SPEED;
    yVel = 0;
    return;
  } else if( keyCode == LEFT ) {
    xVel = -PACMAN_SPEED;
    yVel = 0;
    return;
  }
}

void startNew() {
  running = true;
  paused = false;
  background( BACKGROUND_COLOR );
  xPos = 320;
  yPos = 240;
  xVel = PACMAN_SPEED;
  yVel = 0;
}

void endGame() {
  fill( 200 );
  noStroke();
  rect( 210, 192, 210, 96);
  textSize( 32 );
  fill( 255, 0, 0 );
  text( "YOU DIED", 230, 250 );
  textSize( 16 );
  text( "START OVER?", 259, 277 );
  running = false;
}

boolean checkAlive() {
  if( xPos-10 < 0 || yPos-10 < 0 || xPos+10 > width || yPos+10 > height ) {
    return false;
  }
  return true;
}

void draw() {
  if( running && !paused ) {
    background( BACKGROUND_COLOR );
    
    // DRAW MAP
    // to be implemented later
    fill( (WALL_COLOR >> 16) & 0xFF, (WALL_COLOR >> 8) & 0xFF, WALL_COLOR & 0xFF );
    rect( 370, 10, 10, 460 );

    // CHECK IF PACMAN CAN MOVE
    if( (get( xPos + xVel, yPos + yVel ) & 0xFFFFFF) != WALL_COLOR ) {
      xPos += xVel;
      yPos += yVel;
    }
    
    // DRAW PACMAN
    fill( 255, 255, 51 );
    if( xVel == 0 && yVel < 0 ) {
      startT = 7*PI/4;
      stopT = 13*PI/4;
    }
    else if( xVel == 0 && yVel > 0 ) {
      startT = 3*PI/4;
      stopT = 9*PI/4;
    }
    else if( xVel < 0 ) {
      startT = 5*PI/4;
      stopT = 11*PI/4;
    }
    else {
      startT = PI/4;
      stopT = 7*PI/4;
    }
    arc( xPos, yPos, 20, 20, startT, stopT, PIE );
    // DONE DRAWING PACMAN

    // DRAW GHOSTS
    // to be implemented later

    if( !checkAlive() ) endGame();
  }
}
