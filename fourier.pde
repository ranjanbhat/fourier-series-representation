int count=0;
boolean op=true;
int samples=0;
float t=0;
float dt=0.001;
Circle[] fourier=new Circle[101];
point[] pts=new point[1000];
point[] func=new point[10000];

PrintWriter output;

void mousePressed()
{
  op=!op;
}

void setup()
{
  output = createWriter("check.txt");
  noFill  ();
  stroke(255);
  strokeWeight(4);
  fullScreen();
  for(int i=0; i<101; i++) fourier[i]=new Circle();
  for(int i=0; i<1000; i++){ pts[i]=new point(); }
  for(int i=0; i<10000; i++){ func[i]=new point(); }
  readFunc();
  calculate_cn();
  //for(int i=0; i<=100;i++) output.println(fourier[i].phi);
  //output.flush();
  //output.close();
}

void draw()
{
   background(0);
   translate(width/2,height/2);
   updateCircles();
   if(op)drawCircles();
   drawShape();
   t+=dt;
}

void readFunc()
{
  //String line = null; 
  //BufferedReader reader = createReader("E:\\Coding\\Processing\\fourier\\createfile\\function.txt");
  //try 
  //{
  //  while ((line = reader.readLine()) != null) {
  //    float x = float(line);
  //    line=reader.readLine();
  //    float y = float(line);
  //    func[samples++].x=x;
  //    func[samples].y=y;
  //} 
  //reader.close(); 
  //} catch (IOException e) { 
  //  e.printStackTrace(); }
    
    
  for(int i=0; i<250;i++)
  {
    func[samples++].x=0;
    func[samples  ].y=200;
  }
  for(int i=250; i<500; i++)
  {
    func[samples++].x=0;
    func[samples  ].y=-200;
  }
  //for(int i=0 ; i<500; i++)
  //{
  //    func[samples++].x= 200*cos(2*PI*i/500)+200;
  //    func[samples  ].y= 300*sin(2*PI*i/500)+100;
  //}
}

void drawShape()
{
  for(point p: pts)
  ellipse(p.x,p.y,3.5,3.5);
}

void updateCircles()
{
  for(int i = 51,n=1; i<=100; i++,n++)
  {
    attatch(fourier[-n+50], fourier[ n-1+50]);  //attatch -1 to  0
    attatch(fourier[ n+50], fourier[-n+50  ]);  //attatch  1 to -1
  }
  
  float a=fourier[100].x + fourier[100].r*cos(2*PI*fourier[100].f*t+fourier[100].phi);
  float b=fourier[100].y + fourier[100].r*sin(2*PI*fourier[100].f*t+fourier[100].phi);
  if(count+1<1000)
  {  
    pts[count++].x=a;
    pts[count  ].y=b;
  }
}

void attatch(Circle a, Circle b)
{
  a.x = b.x + b.r*cos(2*PI*b.f*t + b.phi);
  a.y = b.y + b.r*sin(2*PI*b.f*t + b.phi);
  print(b.y , " + " , b.r, "sin(",2*PI*b.f*t," +", b.phi,")" , " = " , a.y);
  println("");
}

void drawCircles()
{
  strokeWeight(0.1);
  for(Circle p : fourier)
  {
    ellipse(p.x,p.y,2*p.r,2*p.r); 
    line(p.x, p.y, 
                  p.x+p.r*cos(2*PI*p.f*t+p.phi),
                  p.y+p.r*sin(2*PI*p.f*t+p.phi));
 
  }
}

class point
{
  float x;
  float y;
  point()
  {
    x=y=0;
  }
}

class Circle
{
  float x;
  float y;
  float r;
  float f;
  float phi;
  Circle()
  {
    x=y=0;
    r=1;
    f=1;
  }
}

void calculate_cn()
{
  for(int i=0,n=-50; i<101; i++, n++)
  {
    float real=0;
    float im=0;
    float step=1.0/samples;
    for(int j=0; j<=samples; j++)
    {
      real+= func[j].x*cos(-2*PI*n*j*step)*step - func[j].y*sin(-2*PI*n*j*step)*step;
      im  += func[j].x*sin(-2*PI*n*j*step)*step + func[j].y*cos(-2*PI*n*j*step)*step;
    }
    fourier[i].r   =  sqrt(real*real+im*im);
    if(real!=0) fourier[i].phi = atan(im/real); else if(im<0) fourier[i].phi=-PI/2; else fourier[i].phi=PI/2; 
    fourier[i].f=n;
  }
}
