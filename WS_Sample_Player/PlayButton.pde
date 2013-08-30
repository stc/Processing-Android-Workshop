class PlayButton extends CircleButton {
  boolean mStartPlaying = true;
  int numero;
  float r, g, b;

  PlayButton(int ix, int iy, int isize, color icolor, color ihighlight, int num) {
    super(ix, iy, isize, icolor, ihighlight);
    numero = num;
    r = red(highlightcolor);
    g = green(highlightcolor);
    b = blue(highlightcolor);
  }


  boolean over() 
  {
    if ( overCircle(x, y, size) ) {
      over = true;
      return true;
    } 
    else {
      over = false;
      return false;
    }
  }

  void playON() {
    if (over() && mousePressed) {

      fill(255);
      onPlay(mStartPlaying, numero);
      highlightcolor = color(255, 53, 0);
      r = red(highlightcolor);
      g = green(highlightcolor);
      b = blue(highlightcolor);
      currentcolor = highlightcolor;
    }
    else {
      colorButton();
      //currentcolor = basecolor;
    }
  }

  void colorButton() {
    if (r<255)r+=5;
    if (g<255) g+=5;
    if (b<255) b+=5;
    currentcolor = color(r, g, b);
    //println(r+"  "+g+"  "+b);
  }

  void display() {
    super.display();
    fill(0);
    textSize(text_size);
    String s = nf(numero, 2);
    float textW = textWidth(s);
    float textH = textAscent() + textDescent();
    text(s, x-textW/2, y+textH/4);
  }
}

