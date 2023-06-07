ArrayList<int[]> possibleMoves = new ArrayList<int[]>();
void getAvailableMoves() {
}

void getBestMove () {
 int bestMove = 0;
 getAvailableMoves();
 for (int i = 0; i < possibleMoves.size(); i++) {
  if (possibleMoves.get(i)[0] < possibleMoves.get(0)[0]) {
   bestMove = i;
  }
 }
}

void doBestMove () {

}
