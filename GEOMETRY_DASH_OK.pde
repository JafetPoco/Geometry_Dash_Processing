import processing.sound.*;
SoundFile menu_music;
SoundFile level_music;

PImage player, back, floor, luz;  //SKIN JUGADOR/FONDO/SUELO/EFECTO LUZ
float begy;  //PUNTO DE INICIO
float finy;  //PUNTO MÁS ALTO DEL SALTO
float gravity;  //ACELERACIÓN DE SUBIDA Y BAJADA
float y;  //ALTURA ACTUAL
boolean up;  //VERIFICA SI ESTA SUBIENDO
float n; //CONTADOR
boolean animation;
float angulo;  //ROTACIÓN
boolean vuelta; //VERIFICA SI VA A DARSE LA VUELTA
int floor_x, back_x; //SUELO VARIABLE MOVIMIENTO EN EJE X/FONDO VARIABLE MOVIMIENTO EN EJE X
float r,g,b; //VARIABLES CAMBIO DE COLOR FONDO
float posi;  //ANIMACION DE POSICION PLATAFORMA
boolean en_aire = false; //VERIFICA QUE NO SALTE CUANDO ESTE EN EL AIRE
boolean esta_tocando = false;
boolean morir = false;
int i=1;
boolean inicio_juego = false;
int m = 0; //CONTADOR INICIO DE NIVEL


//VARIABLES POSICIONES DE LOS BLOQUES
float pos1 = 0;

void setup(){
  surface.setTitle("Geometry Dash by Jafet Poco Chire");
  level_music = new SoundFile(this, "music_level.mp3");
  menu_music = new SoundFile(this, "music_menu.mp3");
  menu_music.loop();
  size(1280,720);
  begy=504;
  y=begy;
  finy=245;
  gravity=0.00;
  up = true;
  n=0;
  angulo=0;
  player = loadImage("data/pers2.png");
  vuelta = false;
  floor = loadImage("data/base.png");
  back = loadImage("data/fondo.png");
  luz = loadImage("data/efec_luz.png");
  r = 29;
  g = 60;
  b = 219;
  floor_x = 0;
  back_x = 0;
  posi = 2000;
}
void draw(){
  if (inicio_juego == false){
    menu();
  } else {
    if (esta_tocando == true){
      //perder();
      fondo();
      plataformas();
      tocar_espina();
      tocar_costado();
      tocar_plataforma();
      person_2();
    } else {
      fondo();
      plataformas();
      //tocar_espina();
      tocar_costado();
      tocar_plataforma();
      person();
    }
    if (morir == true){
      if (angulo % 360 == 0){
        fondo();
        perder();
        level_music.stop();
      } else {
        rotate(radians(180));
        fondo();
        perder();
        level_music.stop();
      }
    }
  }
}

void keyPressed(){
  inicio_juego = true;
  m+=1;
  if (inicio_juego == true && m==1){     //CAMBIA LA MUSICA DEL MENÚ A LA MÚSICA DEL NIVEL
    menu_music.stop();
    level_music.play();
  }
  if (keyCode == UP && en_aire == false && esta_tocando == false){     //VARIABLE SALTO
    gravity=0.24;
    begy=495;
    y=begy;
    finy=300;
    n=0;
    up = true;
    vuelta = true;
    en_aire = true;
  } else if (keyCode == UP && en_aire == false && esta_tocando == true){    //VARIABLES SALTO 2
    gravity=0.18;
    begy=450;
    y=begy;
    finy=191;
    n=0;
    up = true;
    vuelta = true;
    en_aire = true;
  }
}

void menu(){      //MENU DEL JUEGO
  PImage menu_inicio;
  menu_inicio = loadImage("menu_juego.png");
  image(menu_inicio, 0, 0);

}
void fondo(){    //ANIMACIÓN FONDO JUEGO
  background(r,g,b); 
  image(floor,floor_x,627);
  image(floor,floor_x + floor.width-1,627);
  image(back,back_x, 262);
  image(back,back_x + back.width,262);
  image(luz, 645, 530);
  r+=0.07;
  g-=0.0225;
  b-=0.025;
  floor_x-=9;
  back_x-=2;
  if(floor_x < -floor.width){
    floor_x=0;
  }
  if(back_x < -back.width){
    back_x=0;
  }
}

void person(){     //ANIMACION 1 JUGADOR
  translate(250,y);
  imageMode(CENTER);
  rotate(radians(angulo));
  if (vuelta == true){
     angulo+=6;
     if (angulo%180 == 0){
       vuelta = false;
     }
  }
  if (up==true){
    y = begy-((begy-finy)*gravity);
    image(player,0,0);
    begy=y;
    if (begy <= 312){
      up = false;
    }
  } else {
    y = y+(n*gravity);
    n+=3.45;
    image(player,0,0);
    if (y>=492){
      gravity=0;
      en_aire = false;
    }
  } 
  //println(y);
}

void person_2(){     //ANIMACIÓN 2 JUGADOR
  translate(250,y);
  imageMode(CENTER);
  rotate(radians(angulo));
  if (vuelta == true){
     angulo+=6;
     if (angulo%180 == 0){
       vuelta = false;
     }
  }
  if (up==true){
    y = begy-((begy-finy)*gravity);
    image(player,0,0);
    begy=y;
    if (begy <= 280){
      up = false;
    }
  } else {
    y = y+(n*gravity);
    n+=3.45;
    image(player,0,0);
    if (y>=439){
      gravity=0;
      en_aire = false;
    }
  } 
  //println(y);
}

void plataformas(){     //CREA LAS PLATAFORMAS
  PImage base_largo;
  PImage espina;
  PImage base_cuadrado;
  PImage espina_arriba;

  base_largo = loadImage("data/rectangulo.png");
  espina = loadImage("data/espina.png");
  base_cuadrado = loadImage("data/cuadrado.png");
  espina_arriba = loadImage("data/espina_volteada.png");
  image(base_largo,posi,504);
  image(espina, posi+200, 453);
  //image(espina, posi+550, 504);
  image(espina, posi+800,504);
  image(espina, posi+1100,504);
  image(base_largo,posi+1700,504);
  image(espina, posi+2000, 504);
  //image(base_cuadrado, posi+2550, 504);
  image(espina, posi+2650, 504);
  image(espina, posi+2720, 504);
  //image(espina, posi+2820, 504);
  //image(base_cuadrado, posi+2850, 504);
  image(espina, posi+2950, 504);
  image(espina, posi+3350, 504);
  image(espina, posi+3650, 504);
  image(espina, posi+3950, 504);
  image(base_largo,posi+4300,504);
  image(espina, posi+4300, 453);
  image(espina, posi+4600, 504);
  image(base_cuadrado, posi+5200, 504);
  image(espina, posi+5350, 504);
  image(base_cuadrado, posi+5500, 504);
  image(espina, posi+5650, 504);
  image(base_cuadrado, posi+5800, 504);
  image(espina, posi+5950, 504);
  image(base_largo,posi+6250,504);
  image(espina, posi+6250, 453);
  image(espina, posi+6600, 504);
  image(base_largo,posi+6950,504);
  image(espina, posi+7000, 453);
  image(espina, posi+7500, 504);
  image(espina, posi+7800, 504);
  image(espina_arriba, posi+8080, 400);
  image(espina_arriba, posi+8150, 400);
  image(espina_arriba, posi+8220, 400);
  image(espina, posi+8420, 504);
  image(espina, posi+8720, 504);
  image(base_largo,posi+9000,504);
  image(espina_arriba, posi+9000, 330);
  image(espina_arriba, posi+9070, 330);
  image(espina, posi+9350, 504);
  //image(base_cuadrado, posi+9850, 504);
  image(espina, posi+9920, 504);
  image(espina_arriba, posi+10200, 400);
  image(espina_arriba, posi+10270, 400);
  image(espina_arriba, posi+10340, 400);
  image(espina, posi+10700, 504);
  image(espina, posi+11000, 504);
  image(espina_arriba, posi+11000, 200);
  image(espina, posi+11300, 504);
  image(espina_arriba, posi+11300, 200);
  image(espina, posi+11600, 504);
  image(espina_arriba, posi+11600, 200);
  image(espina_arriba, posi+12100, 400);
  image(espina_arriba, posi+12170, 400);
  image(espina_arriba, posi+12240, 400);
  image(espina_arriba, posi+12310, 400);
  image(espina, posi+12550, 504);
  image(base_largo,posi+12890,504);
  image(espina_arriba, posi+12800, 330);
  image(espina_arriba, posi+12870, 330);
  //image(espina, posi+13200, 453);
  //image(espina, posi+13500, 453);
  image(base_largo,posi+13300,504);
  image(espina, posi+13800, 504);
  image(espina, posi+14100, 504);
  image(espina, posi+14400, 504);
  image(espina_arriba, posi+14700, 400);
  image(espina, posi+15000, 504);
  image(espina_arriba, posi+15300, 400);
  //image(base_cuadrado, posi+15800, 504);
  image(espina, posi+15900, 504);
  image(espina, posi+16000, 504);
  //image(base_cuadrado, posi+16080, 504);
  //image(espina, posi+16150, 504);
  image(espina_arriba, posi+16500, 400);
  image(base_largo,posi+17200,504);
  image(espina, posi+17500, 504);
  image(espina_arriba, posi+18070, 400);
  image(espina_arriba, posi+18140, 400);
  image(espina_arriba, posi+18210, 400);
  image(espina_arriba, posi+18280, 400);
  
    
  posi-=9;
  println(posi);
}

void tocar_plataforma(){   //DETECTA EL TOQUE DE LAS PLATAFORMAS
  if(up == false && y>=410 && posi<=464 && posi>=20){
    esta_tocando = true;
  } else if (up == false && y>=410 && posi<=-1236 && posi>=-1680) {
    esta_tocando = true;
  } else if (up == false && y>=410 && posi<=-3700 && posi>=-4300) {
    esta_tocando = true;
  } else if (up == false && y>=410 && posi<=-4900 && posi>=-4990) {
    esta_tocando = true;
  } else if (up == false && y>=410 && posi<=-5200 && posi>=-5290) {
    esta_tocando = true;
  } else if (up == false && y>=410 && posi<=-5500 && posi>=-5590) {
    esta_tocando = true;
  } else if (up == false && y>=410 && posi<=-5800 && posi>=-6244) {
    esta_tocando = true;
  } else if (up == false && y>=410 && posi<=-6200 && posi>=-7000) {
    esta_tocando = true;
  } else if (up == false && y>=410 && posi<=-8485 && posi>=-9100) {
    esta_tocando = true;
  } else if (up == false && y>=410 && posi<=-12350 && posi>=-13350) {
    esta_tocando = true;
  } else if (up == false && y>=410 && posi<=-16666 && posi>=-17220) {
    esta_tocando = true;
  } else {
    esta_tocando = false;
  }
  //println(posi);
}

void tocar_costado(){   //DETECTA EL TOQUE DE LAS PUAS Y COSTADOS DE PLATAFORMAS
  if(posi <= 500 && posi >= 490 && y >=500){
    morir = true;
  }
  if (posi <= -511 && posi >= -529 && y >=400){
    morir = true;
  }
  if (posi <= -790 && posi >= -808 && y >=400){
    morir = true;
  }
  if (posi <= -1200 && posi >= -1210 && y >=400){
    morir = true;
  }
  if (posi <= -1700 && posi >= -1760 && y >=400){
    morir = true;
  }
  if (posi <= -2350 && posi >= -2460 && y >=400){
    morir = true;
  }
  if (posi <= -2640 && posi >= -2680 && y >=400){
    morir = true;
  }
  if (posi <= -3040 && posi >= -3080 && y >=400){
    morir = true;
  }
  if (posi <= -3350 && posi >= -3390 && y >=400){
    morir = true;
  }
  if (posi <= -3650 && posi >= -3690 && y >=400){
    morir = true;
  }
  if (posi <= -4334 && posi >= -4374 && y >=400){
    morir = true;
  }
  if (posi <= -5050 && posi >= -5090 && y >=400){
    morir = true;
  }
  if (posi <= -5350 && posi >= -5390 && y >=400){
    morir = true;
  }
  if (posi <= -5650 && posi >= -5690 && y >=400){
    morir = true;
  }
  if (posi <= -6280 && posi >= -6380 && y >=400){
    morir = true;
  }
  if (posi <= -7210 && posi >= -7250 && y >=400){
    morir = true;
  }
  if (posi <= -7480 && posi >= -7520 && y >=400){
    morir = true;
  }
  if (posi <= -7755 && posi >= -7905 && y <400){
    morir = true;
  }
  if (posi <= -8130 && posi >= -8170 && y >=400){
    morir = true;
  }
  if (posi <= -8440 && posi >= -8480 && y >=400){
    morir = true;
  }
  if (posi <= -8660 && posi >= -8760 && y <400){
    morir = true;
  }
  if (posi <= -9080 && posi >= -9120 && y >=400){
    morir = true;
  }
  if (posi <= -9619 && posi >= -9659 && y >=400){
    morir = true;
  }
  if (posi <= -9900 && posi >= -10200 && y <400){
    morir = true;
  }
  if (posi <= -10420 && posi >= -10460 && y >=400){
    morir = true;
  }
  if (posi <= -10700 && posi >= -10740 && y >=400){
    morir = true;
  }
  if (posi <= -10980 && posi >= -11020 && y >=400){
    morir = true;
  }
  if (posi <= -11270 && posi >= -11310 && y >=400){
    morir = true;
  }
  if (posi <= -11790 && posi >= -12040 && y <400){
    morir = true;
  }
  if (posi <= -12230 && posi >= -12270 && y >=400){
    morir = true;
  }
  if (posi <= -13520 && posi >= -13560 && y >=400){
    morir = true;
  }
  if (posi <= -13795 && posi >= -13835 && y >=400){
    morir = true;
  }
  if (posi <= -14085 && posi >= -14125 && y >=400){
    morir = true;
  }
  if (posi <= -14360 && posi >= -14400 && y <400){
    morir = true;
  }
  if (posi <= -14720 && posi >= -14760 && y >=400){
    morir = true;
  }
  if (posi <= -15010 && posi >= -15050 && y <400){
    morir = true;
  }
  if (posi <= -15590 && posi >= -15710 && y >=400){
    morir = true;
  }
  if (posi <= -16140 && posi >= -16200 && y <400){
    morir = true;
  }
  if (posi <= -16666 && posi >= -16668 && y >=400){
    morir = true;
  }
  if (posi <= -17180 && posi >= -17220 && y >=400){
    morir = true;
  }
  if (posi <= -17791 && posi >= -18031 && y <400){
    morir = true;
  }
}

void tocar_espina(){   //DETECTA ESPINAS NIVEL 2
  if(up == false && y >= 403.38 && esta_tocando == true && posi<=100 && posi>60){
    morir = true;
  }
  if(up == false && y >= 403.38 && esta_tocando == true && posi<=-3975 && posi>-4015){
    morir = true;
  }
  if(up == false && y >= 403.38 && esta_tocando == true && posi<=-5980 && posi>-6020){
    morir = true;
  }
}

void perder(){   //FONDO DE GAMEOVER
  PImage fondo_perder;
  fondo_perder = loadImage("data/gameover_juego.png");
  image(fondo_perder,390,-140);
}

void ganar(){   //FONDO GANADOR
  PImage win;
  win = loadImage("data/win_juego.png");
  image(win,390,-140);
}
  
