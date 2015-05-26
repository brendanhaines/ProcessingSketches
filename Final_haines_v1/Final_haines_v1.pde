final int BACKGROUND_COLOR = 10;
final int PACMAN_SPEED = 2;

boolean running = false;
boolean paused = false;

int xPos;
int yPos;
int xVel = PACMAN_SPEED;
int yVel = 0;

float startT, stopT;

void mouseClicked() {
  if( !running ) {
    running = true;
    startNew();
  }
}

void keyPressed() {
  if( !running ) return;
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

void draw() {
  if( running && !paused ) {
    xPos += xVel;
    yPos += yVel;
    background( BACKGROUND_COLOR );
    
    if( !checkAlive() ) endGame();
    
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
  }
}
