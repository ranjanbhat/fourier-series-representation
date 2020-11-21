boolean isdrawing=false;

PrintWriter output;

void setup()
{
  noFill();
  stroke(255);
  output = createWriter("function.txt"); 
  strokeWeight(4);
  fullScreen();
  background(0);
}

void mousePressed()
{
  if(isdrawing)
  {
    isdrawing=false;
    output.flush();
    output.close();
  }
  else
  {
    background(0);
    isdrawing=true;
  }
}

void draw()
{
  translate(width/2,height/2);
  if(isdrawing)
  {
     output.println(mouseX-width/2);
     output.println(mouseY-height/2);
     point(mouseX-width/2,mouseY-height/2);
  }
}
