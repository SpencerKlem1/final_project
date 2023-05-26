
int gridSizeY = 20;
int gridSizeX = 10;
int pixelSize = 40;


ArrayList <int[]> grid = new ArrayList<int[]>();

int spd = 20;

boolean pieceActive = false;


void setup() {
 size(400, 800);
}

void draw () {
 drawTetrisBoard();
 //shift pieces down
 if (framecount % spd == 0) {
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
int posY = 0
int[] temp;
 for( int row = 0; row < gridSizeY; row++) {
   for (int col = 0; col < gridSizeX; col++) {
     temp = grid.get(row)
     if (temp[col] == 0) {
      fill(255);
     } else {
      fill(0);
     }
     square(posX, posY, pixelSize)
     posX += pixelSize;
   }
   posY += pixelSize;
 }
}

void updateTetrisBoard () {
 if (!pieceActive) {
  
 }
}
void checkTetrisBoard() {
if (pieceActive == true) {
return;
}
int[] temp;
int sum;

for (int row = 0; row < 2; row++) {
  for (int col = 0; col < gridSizeX) {
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
     temp = grid.get(row)
     if (temp[col] != 0) {
      sum++;
     }
     if (sum == 10) {
      grid.remove(row);
      grid.add(new int[]{0, 0, 0, 0, 0, 0, 0, 0, 0, 0});
    }
  }
}

//blank line in grid new int[]{0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
