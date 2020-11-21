void setup()
{
  background(0);
  fullScreen();
  stroke(255);
  translate(width/2,height/2);
  String line = null; 
  BufferedReader reader = createReader("E:\\Coding\\Processing\\fourier\\createfile\\function.txt");
  try 
  {
    while ((line = reader.readLine()) != null) {
      String[] pieces = split(line, "t");
      int x = int(pieces[0]);
      int y = int(pieces[1]);
      point(x, y);
        } 
  reader.close(); 
  } catch (IOException e) { 
    e.printStackTrace(); }
 }

void draw()
{
  
}
