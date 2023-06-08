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
int pieceX; //leftmost x of curpiece on grid
int pieceY; //topmost y of curpiece on grid


ArrayList <int[]> grid = new ArrayList<int[]>();

int spd = 20;
int pieceCooldown = 0;
int rowsRemoved = 0;
int rowMax = 2;


void setup() {
 size(400, 800);
 for (int i = 0; i < gridSizeY; i++) {
 grid.add(new int[]{0, 0, 0, 0, 0, 0, 0, 0, 0, 0}); 
}
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

void keyPressed () {
 if (key == CODED) {
  if (keyCode == LEFT) {
   pieceX--;
   if (!pieceCheck()) {
    pieceX++;
   }
  } else if (keyCode == RIGHT) {
   pieceX++;
   if (!pieceCheck()) {
    pieceX--;
   }
  } else if (keyCode == DOWN) {
    pieceFall();
   }
  } else if (key == 'q' || key == 'Q') {
   rotateLeft(); 
  } else if (key == 'e' || key == 'E') {
   rotateRight(); 
  }
 }

void reset() {

background(255);
//reset grid
for (int i = 0; i < gridSizeY; i++) {
 grid.set(i, new int[]{0, 0, 0, 0, 0, 0, 0, 0, 0, 0}); 
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
  for (int row = 0; row < curPiece.length; row++) {
    for (int col = 0; col < curPiece[row].length; col++) {
  if (curPiece[row][col] == 2) {
   fill(150);
   square((pieceX + col) * pixelSize, (pieceY + row) * pixelSize, pixelSize);
  }
 }
}
}

void updateTetrisBoard () {
 if (!pieceActive) {
 pieceActive = true;
 newPiece();
 if (!pieceCheck()) {
  reset(); 
 }
 return;
 }

if (pieceCooldown > 0) {
 pieceCooldown--;
 if (pieceFall()) {
  pieceCooldown++; 
 }
 if (pieceCooldown == 0) {
  pieceActive = false;
  for (int row = 0; row < curPiece.length; row++) {
    for (int col = 0; col < curPiece[row].length; col++) {
     if (curPiece[row][col] == 2) {
     grid.get(pieceY + row)[pieceX + col] = 1;
     }
    }
   }
   }
   return;
  }
 //piece cannot fall, set timer for ability to change it and before new piece arrives
if (!pieceFall()) {
 pieceCooldown = 2;
 return;
}
 }

void checkTetrisBoard() {
if (pieceActive == true) {
return;
}
int[] temp;
int sum;

for (int row = 0; row < curPiece.length; row++) {
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
      grid.add(0, new int[]{0, 0, 0, 0, 0, 0, 0, 0, 0, 0});
      rowsRemoved++;
      if (rowsRemoved >= rowMax) {
       spd--;
       rowMax *= 2;
      }
    }
  }
}
}

void newPiece () {
 pieceNum = int(random(7));
 strPiece = pieces[pieceNum];
 pieceX = 3;
 pieceY = 0;
 
 switch (pieceNum) {
   case 0:
    curPiece = new int[][]{ {2, 2}, 
                            {2, 2} };
    break;
   case 1:
  //line
    curPiece = new int[][]{ {2, 2, 2, 2} };
   break;
  case 2:
    curPiece = new int[][]{ {2, 0}, 
                            {2, 2}, 
                            {2, 0} };
    break;
  case 3:
    curPiece = new int[][]{ {0, 2}, 
                            {0, 2}, 
                            {2, 2} };
    break;
  case 4:
    curPiece = new int[][]{ {2, 0}, 
                            {2, 0}, 
                            {2, 2} };
    break;
  case 5:
    curPiece = new int[][]{ {0, 2}, 
                            {2, 2}, 
                            {2, 0} };
    break;
  case 6:
    curPiece = new int[][]{ {2, 0}, 
                            {2, 2}, 
                            {0, 2} };
    break;
 }
}

boolean pieceFall() {
 pieceY++;
 if (!pieceCheck()) {
 pieceY--;
 return false;
 }
 return true;
}

boolean pieceCheck() {
   //piece is in bounds or not
   if (pieceY + curPiece.length > gridSizeY) {
    return false;
   } else if (pieceX < 0 || pieceX + curPiece[0].length > gridSizeX) {
    return false;
   }
   
   for (int row = 0; row < curPiece.length; row++)  {
    for (int col = 0; col < curPiece[row].length; col++) {
     if (curPiece[row][col] == 2 && grid.get(pieceY + row)[pieceX + col] != 0) {
      return false;
      }
    }
}
    return true;
}

boolean pieceCheck(int newX, int newY, int[][] newCurPiece) {
   //piece is in bounds or not
   if (newY + newCurPiece.length > gridSizeY) {
    return false;
   } else if (newX < 0 || newX + newCurPiece[0].length > gridSizeX) {
    return false;
   }
   
   for (int row = 0; row < newCurPiece.length; row++)  {
    for (int col = 0; col < newCurPiece[row].length; col++) {
     if (newCurPiece[row][col] == 2 && grid.get(newY + row)[newX + col] != 0) {
      return false;
      }
    }
}
    return true;
}
void rotateLeft () { 

    int[][] newCurPiece = new int[curPiece[0].length][curPiece.length];
    int newColumn, newRow = 0;
    for (int oldColumn = curPiece[0].length - 1; oldColumn >= 0; oldColumn--)
    {
        newColumn = 0;
        for (int oldRow = 0; oldRow < curPiece.length; oldRow++)
        {
            newCurPiece[newRow][newColumn] = curPiece[oldRow][oldColumn];
            newColumn++;
        }
        newRow++;
    }
  if (pieceCheck(pieceX, pieceY, newCurPiece)) {
 curPiece = newCurPiece;
 } else if (pieceCheck(pieceX - 1, pieceY, newCurPiece)) {
  curPiece = newCurPiece;
  pieceX--;
 } else if (pieceCheck(pieceX, pieceY - 1, newCurPiece)) {
  curPiece = newCurPiece;
  pieceY--;
 }
  
}

void rotateRight () { 
    int[][] newCurPiece = new int[curPiece[0].length][curPiece.length];
    int newColumn, newRow = 0;
    for (int oldColumn = 0; oldColumn < curPiece[0].length; oldColumn++)
    {
        newColumn = 0;
        for (int oldRow = curPiece.length - 1; oldRow >= 0 ; oldRow--)
        {
            newCurPiece[newRow][newColumn] = curPiece[oldRow][oldColumn];
            newColumn++;
        }
        newRow++;
    }
 if (pieceCheck(pieceX, pieceY, newCurPiece)) {
 curPiece = newCurPiece;
 } else if (pieceCheck(pieceX - 1, pieceY, newCurPiece)) {
  curPiece = newCurPiece;
  pieceX--;
 } else if (pieceCheck(pieceX, pieceY - 1, newCurPiece)) {
  curPiece = newCurPiece;
  pieceY--;
 }
}

//blank line in grid new int[]{0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
