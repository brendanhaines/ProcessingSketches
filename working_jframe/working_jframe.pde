import javax.swing.*;

JFrame frame = new JFrame("Embedded PApplet");
frame.setResizable(true);
frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
PApplet embed = new PApplet();
frame.add(embed);
embed.init();
while (embed.defaultSize&&!embed.finished)
 try {Thread.sleep(5);} catch (Exception e) {}
frame.pack();
frame.setVisible(true);
