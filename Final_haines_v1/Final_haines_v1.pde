import javax.swing.*;

final int BACKGROUND_COLOR = 10;
final int WALL_COLOR = 0xCCCCCC;
final int PACMAN_SPEED = 2;
final int GHOST_SPEED = 1;

JFrame options = new JFrame( "Options" );
JCheckBox redGhost = new JCheckBox( "Red Ghost" );
JCheckBox blueGhost = new JCheckBox( "Blue Ghost" );
JCheckBox greenGhost = new JCheckBox( "Green Ghost" );
JCheckBox pinkGhost = new JCheckBox( "Pink Ghost" );

int redX = 10;
int redY = 10;
int blueX = 10;
int blueY = 30;
int greenX = 10;
int greenY = 50;
int pinkX = 10;
int pinkY = 70;

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

  options.getContentPane().setLayout( new BoxLayout( options.getContentPane(), BoxLayout.Y_AXIS ) );
  options.setDefaultCloseOperation( JFrame.DO_NOTHING_ON_CLOSE );
  redGhost.setSelected( true );
  options.add( redGhost );
  options.add( blueGhost );
  options.add( greenGhost );
  options.add( pinkGhost );
  options.pack();
  options.setVisible( true );
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
    // movement to be implemented later
    if( redGhost.isSelected() ) {
      fill( 255, 0, 0 );
      drawGhost( redX, redY );
    }
    if( blueGhost.isSelected() ) {
      fill( 0, 0, 255 );
      drawGhost( blueX, blueY );
    }
    if( greenGhost.isSelected() ) {
      fill( 0, 255, 0 );
      drawGhost( greenX, greenY );
    }
    if( pinkGhost.isSelected() ) {
      fill( 230, 76, 194 );
      drawGhost( pinkX, pinkY );
    }

    if( !checkAlive() ) endGame();
  }
}

void drawGhost( int x, int y ) {
  translate( x, y );
  beginShape();
  vertex( 8, -6 );
  vertex( 7, -8 );
  vertex( 6, -9 );
  vertex( 4, -10 );
  vertex( -4, -10 );
  vertex( -6, -9 );
  vertex( -7, -8 );
  vertex( -8, -6 );
  vertex( -8, 2 );
  vertex( -9, 4 );
  vertex( -9, 6 );
  vertex( -8, 8 );
  vertex( -8, 6 );
  vertex( -6, 8 );
  vertex( -6, 6 );
  vertex( -4, 8 );
  vertex( -4, 6 );
  vertex( -2, 8 );
  vertex( -2, 6 );
  vertex( 0, 8 );
  vertex( 2, 6 );
  vertex( 2, 8 );
  vertex( 4, 6 );
  vertex( 4, 8 );
  vertex( 6, 6 );
  vertex( 6, 8 );
  vertex( 8, 6 );
  vertex( 8, 8 );
  vertex( 9, 6 );
  vertex( 9, 4 );
  vertex( 8, 2 );
  vertex( 8, -6 );
  endShape();
  fill( BACKGROUND_COLOR );
  ellipse( 3, -4, 2, 2 );
  ellipse( -3, -4, -2, 2 );
  translate( -x, -y );
}
