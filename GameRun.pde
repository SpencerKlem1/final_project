int gridSizeY = 20;
int gridSizeX = 10;
int pixelSize = 40;

int[][]   curPiece = new int[][]
              {{0, 0, 0, 0},
              {0, 0, 0, 0},
              {0, 0, 0, 0},
              {0, 0, 0, 0}};
int pieceNum;
boolean pieceActive = false;
String[] pieces = new String[]{ "sq", "li", "t", "rl", "ll", "rz", "lz"};
String strPiece;

ArrayList <int[]> grid = new ArrayList<int[]>();

int spd = 20;




void setup() {
 size(400, 800);
 reset();
}

void draw () {
 drawTetrisBoard();
 //shift pieces down
 if (frameCount % spd == 0) {
  updateTetrisBoard();
  checkTetrisBoard();
 }
}

void reset() {

background(255);
//reset grid
for (int i = 0; i < gridSizeY; i++) {
 grid.add(new int[]{0, 0, 0, 0, 0, 0, 0, 0, 0, 0}); 
}


}

void drawTetrisBoard() {

//draws white squares in parts of array where needed, black squares otherwise
int posX = 0;
int posY = 0;
int[] temp;
 for( int row = 0; row < gridSizeY; row++) {
   posX = 0;
   for (int col = 0; col < gridSizeX; col++) {
     temp = grid.get(row);
     if (temp[col] == 0) {
      fill(255);
     } else {
      fill(0);
     }
     square(posX, posY, pixelSize);
     posX += pixelSize;
     //System.out.println(posX + " " + posY);
   }
   posY += pixelSize;
 }
}

void updateTetrisBoard () {
 if (!pieceActive) {
  return;
 }
 newPiece();
 
}
void checkTetrisBoard() {
if (pieceActive == true) {
return;
}
int[] temp;
int sum;

for (int row = 0; row < 2; row++) {
  for (int col = 0; col < gridSizeX; col++) {
   temp = grid.get(row);
   if (temp[col] != 0) {
    reset();
    return;
   }
  }
}

//removes complete rows

 for( int row = 0; row < gridSizeY; row++) {
   sum = 0;
   for (int col = 0; col < gridSizeX; col++) {
     temp = grid.get(row);
     if (temp[col] != 0) {
      sum++;
     }
     if (sum == 10) {
      grid.remove(row);
      grid.add(new int[]{0, 0, 0, 0, 0, 0, 0, 0, 0, 0});
    }
  }
}
}

void newPiece () {
 pieceNum = int(random(7));
 strPiece = pieces[pieceNum];
 
 switch (pieceNum) {
   case 0:
    curPiece[0][1] = 1;
    curPiece[0][2] = 1;
    curPiece[1][1] = 1;
    curPiece[1][2] = 1;
    break;
   case 1:
  //line
   curPiece[0][0] = 1;
   curPiece[0][1] = 1;
   curPiece[0][2] = 1;
   curPiece[0][3] = 1;
   break;
  case 2:
    curPiece[0][0] = 1;
    curPiece[0][1] = 1;
    curPiece[0][2] = 1;
    curPiece[1][1] = 1;
    break;
  case 3:
    curPiece[1][0] = 1;
    curPiece[1][1] = 1;
    curPiece[1][2] = 1;
    curPiece[2][2] = 1;
    break;
  case 4:
    curPiece[2][0] = 1;
    curPiece[2][1] = 1;
    curPiece[2][2] = 1;
    curPiece[1][2] = 1;
    break;
  case 5:
    curPiece[0][1] = 1;
    curPiece[1][1] = 1;
    curPiece[1][2] = 1;
    curPiece[2][2] = 1;
    break;
  case 6:
    curPiece[0][2] = 1;
    curPiece[1][2] = 1;
    curPiece[1][1] = 1;
    curPiece[2][1] = 1;
    break;
 }
}

//blank line in grid new int[]{0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
