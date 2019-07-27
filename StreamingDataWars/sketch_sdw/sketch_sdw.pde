
import twitter4j.conf.*;
import twitter4j.api.*;
import twitter4j.*;


float numeroCaptura = random(50);
int CapturaNumero =1;

String val;

Boolean activo= true;

PFont f;

String hashtag1;
String hashtag2;

boolean toggleInfo = true;

int mencionesHashtag1=0;
int mencionesHashtag2=0;


String TwittActual1="";
String TwittActual2="";

// generacion grafica

//alto y ancho grafico
int resolucionW = 1366;
int resolucionH = 768;

int valorAleX1 = 0;
int valorAleY1 = 0;

int valorAleX2 = 0;
int valorAleY2 = 0;
  
PGraphics pg;

int valorFinal1 = 0;
int valorActual1 = 0;

int valorFinal2 = 0;
int valorActual2 = 0;

ConfigurationBuilder  cb;

void setup() {
  
  background(64,64,64);
  smooth();
  
  size(1366, 768);
  f = createFont("DroidSans",12,true);

  pg = createGraphics(600, 200);
  // valores hashtags a comparar

  hashtag1="love";
  hashtag2="porn";


    // key3

  cb = new ConfigurationBuilder();
  cb.setOAuthConsumerKey("xxx");
  cb.setOAuthConsumerSecret("xxx");
  cb.setOAuthAccessToken("xxx-xxx");
  cb.setOAuthAccessTokenSecret("xxx");

  
  StatusListener listener = new StatusListener() {
      

      @Override
        public void onScrubGeo(long userId, long upToStatusId) {
        System.out.println("Got scrub_geo event userId:" + userId + " upToStatusId:" + upToStatusId);
  
      }
   
      @Override
        public void onStallWarning(StallWarning warning) {
        System.out.println("Got stall warning:" + warning);

      }
    
      //Imprimimos tweets
      public void onStatus(Status status) {
        
        String[] m1 = match(status.getText(), hashtag1);
        
        
        if (m1 != null) {
              
              mencionesHashtag1 = mencionesHashtag1+1;
              
              
              //drawItem1();
              //creamos una figura cada vez que se menciona el keyword 1

              m1 = null;
              
              TwittActual1 = status.getText();
              //TwittActual2 = "";
    
              
        }
        
        String[] m2 = match(status.getText(), hashtag2);
        //drawItem2();
        
        if (m2 != null) {
          
              mencionesHashtag2 = mencionesHashtag2+1;
              //drawItem2();
                   
              m2 = null;
              
              TwittActual2 = status.getText();
              //TwittActual1="";
              
              //creamos una figura cada vez que se menciona el keyword 2
             
              
        }
        
        
      }
      
      public void onDeletionNotice(StatusDeletionNotice statusDeletionNotice) {}
      public void onTrackLimitationNotice(int numberOfLimitedStatuses) {}
      public void onException(Exception ex) {
        ex.printStackTrace();
      }
        
  };
  
  TwitterStream twitterStream = new TwitterStreamFactory(cb.build()).getInstance();
  twitterStream.addListener(listener);
 
 // aqui recogemos el hashtag
  String keywords[] = {
    hashtag1,
    hashtag2
  };
 
  FilterQuery fq = new FilterQuery(); 
  fq.track(keywords); 
  twitterStream.filter(fq);
  
  

}


void draw() {
    
  drawItem1(mencionesHashtag1);
  drawItem2(mencionesHashtag2);
  

  pg.beginDraw();
  pg.background(51);
  
  //pg.stroke(255);
  //pg.line(20, 20, mouseX, mouseY);
  
  pg.textFont(f);
  pg.fill(255,255,255); 
    
  // Equipo 01
  pg.fill(255,197,179); 
  pg.text("Hashtag  1 (salmón): "+hashtag1,15,25);
  pg.fill(255,255,255); 
  
  pg.text("Número menciones: "+mencionesHashtag1,15,47); //22
   
  pg.text("Twitt actual:",15,67);
  pg.text(TwittActual1,15,80,260,250);
   

  // Equipo 02
  pg.fill(153, 232, 186); 
  pg.text("Hashtag  2 (verde): "+hashtag2,315,25);
  pg.fill(255,255,255); 
  pg.text("Número menciones: "+mencionesHashtag2,315,47); //22
  
  pg.text("Twitt actual:",315,67);
  pg.text(TwittActual2,315,80,260,250);

  
  pg.endDraw();
  if(toggleInfo) { 
    image(pg, 0,0); 
  } else {
    image(pg, 0,0); 
  }
    
    
}


void keyPressed() {
  CapturaNumero += 1;
   save("grafico"+int(numeroCaptura)+CapturaNumero+".png");
   println("Image Save");
 
   
   if (keyCode == 86) {
     
     toggleInfo = !toggleInfo;
     println(toggleInfo);
   }
   
   
}


void drawItem1(int valor1) {
  
    valorAleX1 = int(random(0,resolucionW));
    valorAleY1 = int(random(0,resolucionH));
  
    valorActual1 = valor1;
    
    for(int i = valorFinal1; i < valorActual1; i= i+1 ) {
      
      
      //stroke(255);
      stroke(255,197,179);
      //noStroke();
      fill(255,197,179);
      //fill(255,197,179);
       int sizeItem2 = int(random(5,305));
      ellipse(valorAleX1,valorAleY1,sizeItem2,sizeItem2);
      
    }
    
    valorFinal1 = valorActual1;
}

void drawItem2(int valor2) {
  
    valorAleX2 = int(random(0,resolucionW));
    valorAleY2 = int(random(0,resolucionH));
  
    valorActual2 = valor2;
    
    for(int i = valorFinal2; i < valorActual2; i= i+1 ) {
      
  
      stroke(153, 232, 186);
      //noStroke();
      //fill(153, 232, 186);
      fill(153, 232, 186);
      int sizeItem1 = int(random(5,305));
      ellipse(valorAleX2,valorAleY2,sizeItem1,sizeItem1);
      
    }
    
    valorFinal2 = valorActual2;
}
