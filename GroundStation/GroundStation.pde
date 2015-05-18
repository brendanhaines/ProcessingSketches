import javax.swing.*;

final int backgroundColor = 51;
Copter copter = new Quad();

JFrame frame = new JFrame( "blah" );
frame.setResizable( true );
frame.setDefaultCloseOperation( JFrame.EXIT_ON_CLOSE );
JButton button = new JButton( "blah" );
frame.add( button );
frame.pack();
frame.setVisible( true );

void setup(){
  size( 640, 360, P3D );
  background( backgroundColor );
}

void draw(){
  
  // Begin to draw new image
  background( backgroundColor );
  copter.draw3d();
}
