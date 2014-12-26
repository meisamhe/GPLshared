package board;

/**
 * <p>Title: </p>
 *
 * <p>Description: </p>
 *
 * <p>Copyright: Copyright (c) 2007</p>
 *
 * <p>Company: </p>
 *
 * @author not attributable
 * @version 1.0
 */
import java.util.Random;

public class board {
    cell boardCell[][];
    cell boardCellBuffer[][];
    int bufferRow; // to check wether buffer is empty or not
    int firstTowRow, secondTowRow, thirdTowRow, fourthTowRow; // to understand wether each part is matched or not
    msAccessDB msadb; // for doing things with db
    // These are patterns to fill the board 17*32*2
    int pattern[][][] = { { {0, 9}, {1, 17}, {8, 24}, {25, 16}, {2, 11}, {3, 19},
                        {10, 26}, {18, 27}, {32, 41}, {40, 56}, {48, 57}, {49,
                        33}, {34, 43}, {35, 51}, {42, 58}, {59, 50}, {4, 13},
                        {5, 7}, {6, 15}, {12, 14}, {20, 29}, {21, 37}, {28, 44},
                        {36, 45}, {22, 31}, {23, 39}, {30, 46}, {38, 47}, {52,
                        61}, {53, 55}, {60, 62}, {63, 54}
    }, { {0, 9}, {1, 17}, {8, 24}, {25, 16}, {6, 15}, {7, 23}, {14, 30}, {22,
            31}, {32, 41}, {40, 56}, {48, 57}, {49, 33}, {38, 47}, {39, 55},
            {46, 62}, {63, 54}, {2, 11}, {3, 5}, {4, 13}, {10, 12}, {18, 27},
            {19, 35}, {26, 42}, {34, 43}, {20,
            29}, {21, 37}, {28, 44}, {36, 45}, {50, 59}, {51, 53}, {58, 60},
            {61, 52}
    }, { {4, 13}, {5, 21}, {12, 28}, {29, 20}, {6, 15}, {7, 23}, {14, 30}, {22,
            31}, {36, 45}, {44, 60}, {52, 61}, {53,
            37}, {38, 47}, {39, 55}, {46, 62}, {63, 54}, {0, 9}, {1, 3}, {2,
            11}, {8, 10}, {16, 25}, {17, 33}, {24, 40}, {32, 41}, {18, 27}, {19,
            35}, {26, 42}, {34, 43}, {48,
            57}, {49, 51}, {56, 58}, {59, 50}
    }, { {0, 9}, {1, 17}, {8, 24}, {25, 16}, {6, 15}, {7, 23}, {14, 30}, {22,
            31}, {32, 41}, {40, 56}, {48, 57}, {49, 33}, {38, 47}, {39, 55},
            {46, 62}, {63, 54}, {2, 11}, {3, 5}, {4, 13}, {10, 12}, {18, 27},
            {19, 21}, {26, 28}, {20, 29}, {34,
            43}, {42, 58}, {35, 51}, {50, 59}, {36, 45}, {44, 60}, {37, 53},
            {61, 52}
    }, { {4, 13}, {5, 21}, {12, 28}, {29, 20}, {6, 15}, {7, 23}, {14, 30}, {22,
            31}, {36, 45}, {44, 60}, {52, 61}, {53, 37}, {38, 47}, {39, 55},
            {46,
            62}, {63, 54}, {0, 9}, {1, 3}, {2, 11}, {8, 10}, {16, 25}, {17, 19},
            {24, 26}, {18, 27}, {32,
            41}, {40, 56}, {33, 49}, {48, 57}, {34, 43}, {42, 58}, {35, 51},
            {59, 50}
    }, { {0, 9}, {1, 17}, {8, 24}, {25, 16}, {2, 11}, {3, 19}, {10, 26}, {18,
            27}, {32, 41}, {40, 56}, {48, 57}, {49, 33}, {34, 43}, {35, 51},
            {42,
            58}, {59, 50}, {4, 13}, {5, 7}, {6, 15}, {12, 14}, {20, 29}, {21,
            23}, {28, 30}, {22, 31}, {36,
            45}, {44, 60}, {37, 53}, {52, 61}, {38, 47}, {46, 62}, {39, 55},
            {63, 54}
    }, { {0, 9}, {1, 17}, {8, 24}, {25, 16}, {2, 11}, {3, 19}, {10, 26}, {18,
            27}, {32, 41}, {40, 56}, {48, 57}, {49, 33}, {34, 43}, {35, 51},
            {42,
            58}, {59, 50}, {4, 13}, {5, 21}, {12, 28}, {20, 29}, {6, 15}, {7,
            23}, {14, 30}, {22, 31}, {36,
            45}, {37, 39}, {38, 47}, {44, 46}, {52, 61}, {53, 55}, {54, 63},
            {60, 62}
    }, { {4, 13}, {5, 21}, {12, 28}, {29, 20}, {6, 15}, {7, 23}, {14, 30}, {22,
            31}, {36, 45}, {44, 60}, {52, 61}, {53, 37}, {38, 47}, {39, 55},
            {46,
            62}, {63, 54}, {0, 9}, {1, 17}, {8, 24}, {16, 25}, {2, 11}, {3,
            19}, {10, 26}, {18, 27}, {32,
            41}, {33, 35}, {34, 43}, {40, 42}, {48, 57}, {49, 51}, {50, 59},
            {56, 58}
    }, { {0, 9}, {1, 17}, {8, 24}, {25, 16}, {6, 15}, {7, 23}, {14, 30}, {22,
            31}, {32, 41}, {40, 56}, {48, 57}, {49, 33}, {38, 47}, {39, 55},
            {46,
            62}, {63, 54}, {2, 11}, {3, 19}, {10, 26}, {18, 27}, {4, 13}, {5,
            21}, {12, 28}, {20, 29}, {34,
            43}, {35, 37}, {36, 45}, {42, 44}, {50, 59}, {51, 53}, {52, 61},
            {58, 60}
    }, { {0, 9}, {1, 17}, {8, 24}, {25, 16}, {6, 15}, {7, 23}, {14, 30}, {22,
            31}, {36, 45}, {44, 60}, {52, 61}, {53, 37}, {38, 47}, {39, 55},
            {46,
            62}, {63, 54}, {2, 11}, {3, 5}, {10, 12}, {4, 13}, {18, 27}, {19,
            21}, {26, 28}, {20, 29}, {32,
            41}, {33, 35}, {40, 42}, {34, 43}, {48, 57}, {49, 51}, {56, 58},
            {50, 59}
    }, { {0, 9}, {1, 17}, {8, 24}, {25, 16}, {2, 11}, {3, 19}, {10, 26}, {18,
            27}, {32, 41}, {40, 56}, {48, 57}, {49, 33}, {38, 47}, {39, 55},
            {46,
            62}, {63, 54}, {4, 13}, {5, 7}, {12, 14}, {6, 15}, {20, 29}, {21,
            23}, {28, 30}, {22, 31}, {34,
            43}, {35, 37}, {36, 45}, {42, 44}, {50, 59}, {51, 53}, {52, 61},
            {58, 60}
    }, { {0, 9}, {1, 17}, {8, 24}, {25, 16}, {2, 11}, {3, 19}, {10, 26}, {18,
            27}, {32, 41}, {40, 56}, {48, 57}, {49, 33}, {34, 43}, {35, 51},
            {42,
            58}, {59, 50}, {4, 13}, {5, 7}, {12, 14}, {6, 15}, {20, 29}, {21,
            23}, {28, 30}, {22, 31}, {36,
            45}, {37, 39}, {38, 47}, {44, 46}, {52, 61}, {53, 55}, {54, 63},
            {60, 62}
    }, { {4, 13}, {5, 21}, {12, 28}, {29, 20}, {6, 15}, {7, 23}, {14, 30}, {22,
            31}, {36, 45}, {44, 60}, {52, 61}, {53, 37}, {38, 47}, {39, 55},
            {46,
            62}, {63, 54}, {0, 9}, {1, 3}, {8, 10}, {2, 11}, {16, 25}, {17,
            19}, {24, 26}, {18, 27}, {32,
            41}, {33, 35}, {34, 43}, {40, 42}, {48, 57}, {49, 51}, {50, 59},
            {56, 58}
    }, { {4, 13}, {5, 21}, {12, 28}, {29, 20}, {6, 15}, {7, 23}, {14, 30}, {22,
            31}, {36, 45}, {44, 60}, {52, 61}, {53, 37}, {38, 47}, {39, 55},
            {46,
            62}, {63, 54}, {0, 9}, {1, 17}, {8, 24}, {16, 25}, {2, 11}, {3,
            19}, {10, 26}, {18, 27}, {32,
            41}, {33, 49}, {40, 56}, {48, 57}, {34, 43}, {42, 58}, {35, 51},
            {50, 59}
    }, { {4, 13}, {5, 7}, {12, 14}, {6, 15}, {20, 29}, {21, 23}, {28, 30}, {22,
            31}, {36, 45}, {37, 39}, {44, 46}, {38, 47}, {52, 61}, {53, 55},
            {60,
            62}, {54, 63}, {0, 9}, {1, 3}, {8, 10}, {2, 11}, {16, 25}, {17,
            19}, {24, 26}, {18, 27}, {32,
            41}, {33, 35}, {34, 43}, {40, 42}, {48, 57}, {49, 51}, {50, 59},
            {56, 58}
    }, { {32, 41}, {33, 49}, {40, 56}, {57, 48}, {38, 47}, {39, 55}, {46, 62},
            {54,
            63}, {0, 9}, {8, 24}, {16, 25}, {17, 1}, {6, 15}, {7, 23}, {14,
            30}, {31, 22}, {34, 43}, {35, 51}, {42, 58}, {50, 59}, {36, 45},
            {37,
            53}, {44, 60}, {52, 61}, {2,
            11}, {3, 5}, {4, 13}, {10, 12}, {18, 27}, {19, 21}, {20, 29}, {26,
            28}
    }, { {32, 41}, {33, 49}, {40, 56}, {57, 48}, {34, 43}, {35, 51}, {42, 58},
            {50,
            59}, {0, 9}, {8, 24}, {16, 25}, {17, 1}, {6, 15}, {7, 23}, {14,
            30}, {31, 22}, {36, 45}, {37, 39}, {44, 46}, {38, 47}, {52, 61},
            {53,
            55}, {60, 62}, {54, 63}, {2,
            11}, {3, 5}, {4, 13}, {10, 12}, {18, 27}, {19, 21}, {20, 29}, {26,
            28}
    }

    };
    int imagePattern[][][] = { { {1, 2, 3, 4}, {2, 1, 4, 3}, {1, 2, 3, 4}, {2,
                             1, 4, 3}
    }, { {1, 2, 1, 2}, {2, 1, 2, 1}, {3, 4, 3, 4}, {4, 3, 4, 3}
    }
    };
    public board() {
        msadb = new msAccessDB();
        setFirstTowRow();
        setSecondTowRow();
        setThirdTowRow();
        setFourthTowRow();
        String result[][];
        result = new String[32][2];
        msadb.fillArray(result);
        boardCell = new cell[8][8];
        boardCellBuffer = new cell[8][8];
        Random generator = new Random();
//        int image11 = generator.nextInt(14);
        int patternNum = generator.nextInt(17); // for it is started form 0
        int x;
        int y;
//        System.out.println(patternNum);
        for (int i = 0; i < 32; i++) {
//            System.out.println(result[i][0] + " " + result[i][1]);
            x = pattern[patternNum][i][1] % 8 * 100 + 100;
            y = (pattern[patternNum][i][1] / 8) * 100 + 150;
            boardCell[pattern[patternNum][i][1] / 8][pattern[patternNum][i][1] %
                    8] = new cell(x, y, 0, result[i][0]
                                  , result[i][1], true);
            x = pattern[patternNum][i][0] % 8 * 100 + 100;
            y = (pattern[patternNum][i][0] / 8) * 100 + 150;
            boardCell[pattern[patternNum][i][0] / 8][pattern[patternNum][i][0] %
                    8] = new cell(x, y, 0, result[i][1]
                                  , result[i][0], false); // the meaning is persian
        }
        int imagePatternNum = 0;
        int image[] = new int[4];
        for (int i = 0; i < 4; i++) {
            imagePatternNum = generator.nextInt(2);
            for (int j = 0; j < 4; j++) { // with this we generate images
                image[j] = 1 + generator.nextInt(14); // For it is started from 0
            }
            for (int j = 0; j < 16; j++) {
                boardCell[4 * (i / 2) + (j / 4)][4 * (i % 2) + (j % 4)].
                        setImageNum(image[imagePattern[imagePatternNum][j / 4
                                    ][j % 4] - 1]); //for it is started from 0
            }
        }
        bufferRow = 0;
    }

    void setFirstTowRow() {
        firstTowRow = 0;
    }

    void setSecondTowRow() {
        secondTowRow = 0;
    }

    void setThirdTowRow() {
        thirdTowRow = 0;
    }

    void setFourthTowRow() {
        fourthTowRow = 0;
    }

    void increaseFirstTowRow() {
        firstTowRow += 1;
    }

    void increaseSecondTowRow() {
        secondTowRow += 1;
    }

    void increaseThirdTowRow() {
        thirdTowRow += 1;
    }

    void increaseFourthTowRow() {
        fourthTowRow += 1;
    }

    void updateBufferRow() { //for each time that a row is inserted into mainboard
        bufferRow--;
    }

    void fillBuffer() {
        bufferRow = 4; // for it fills 4*2 rows
        String result[][];
        result = new String[32][2];
        msadb.fillArray(result);
        Random generator = new Random();
//        int image11 = generator.nextInt(14);
        int patternNum = generator.nextInt(17); // for it is started form 0
        int x;
        int y;
//        System.out.println(patternNum);
        for (int i = 0; i < 32; i++) {
//            System.out.println(result[i][0] + " " + result[i][1]);
            x = pattern[patternNum][i][1] % 8 * 100 + 100;
            y = (pattern[patternNum][i][1] / 8) * 100 + 150;
            boardCellBuffer[pattern[patternNum][i][1] /
                    8][pattern[patternNum][i][1] %
                    8] = new cell(x, y, 0, result[i][0]
                                  , result[i][1], true);
            x = pattern[patternNum][i][0] % 8 * 100 + 100;
            y = (pattern[patternNum][i][0] / 8) * 100 + 150;
            boardCellBuffer[pattern[patternNum][i][0] /
                    8][pattern[patternNum][i][0] %
                    8] = new cell(x, y, 0, result[i][1]
                                  , result[i][0], false); // the meaning is persian
        }
        int imagePatternNum = 0;
        int image[] = new int[4];
        for (int i = 0; i < 4; i++) {
            imagePatternNum = generator.nextInt(2);
            for (int j = 0; j < 4; j++) { // with this we generate images
                image[j] = 1 + generator.nextInt(14); // For it is started from 0
            }
            for (int j = 0; j < 16; j++) {
                boardCellBuffer[4 * (i / 2) + (j / 4)][4 * (i % 2) + (j % 4)].
                        setImageNum(image[imagePattern[imagePatternNum][j / 4
                                    ][j % 4] - 1]); //for it is started from 0
            }
        }

    }

    int check(String Meaning, int cellNum, int firstSelected,
              int secondSelected) { // this function will return the cell which
        //should be matched
        int directionX, directionY; // could be 0 or 1
        directionX = (secondSelected - firstSelected) % 8;
        directionY = (secondSelected - firstSelected) / 8;
//        System.out.println("directionX is:" + directionX + "directionY is:" +
//                           directionY);
//        System.out.println("cellNum is:"+cellNum);
        if ((cellNum + 8 * directionY) / 8 != 0) {
//            System.out.println(Meaning + " " + Meaning +
//                               boardCell[((cellNum+8*directionY) / 8) -
//                               1][(cellNum+directionX) % 8].content);
            if (Meaning ==
                boardCell[((cellNum + 8 * directionY) / 8) -
                1][(cellNum + directionX) % 8].content) {
                return cellNum + 8 * directionY + directionX - 8;
            }
        }
        if ((cellNum + 8 * directionY) / 8 != 7) {
//            System.out.println(Meaning + " " + Meaning +
//                               boardCell[((cellNum+8*directionY) / 8) +
//                               1][(cellNum+directionX) % 8].content);
            if (Meaning ==
                boardCell[((cellNum + 8 * directionY) / 8) +
                1][(cellNum + directionX) % 8].content) {
                return cellNum + 8 * directionY + directionX + 8;
            }
        }
        if ((cellNum + directionX) % 8 != 7) {
//            System.out.println(Meaning + " " + Meaning +
//                               boardCell[((cellNum + 8*directionY) / 8)][(cellNum +
//                    directionX) % 8 + 1].content);
            if (Meaning ==
                boardCell[((cellNum + 8 * directionY) /
                           8)][(cellNum + directionX) % 8 + 1].content) {

                return cellNum + directionX + 8 * directionY + 1;
            }
        }
        if ((cellNum + directionX) % 8 != 0) {
//            System.out.println(Meaning + " " + Meaning +
//                               boardCell[((cellNum + 8*directionY) / 8)][(cellNum +
//                    directionX) %
//                               8 - 1].content);

            if (Meaning ==
                boardCell[((cellNum + 8 * directionY) / 8)][(cellNum +
                    directionX) %
                8 - 1].content) {
                return cellNum + directionX + 8 * directionY - 1;
            }
        }

        return -1;
    }

    void updateBoard(int i, int j) { // for updating four variables
        boardCell[i / 8][i % 8].setPlace(true);
        msadb.leitnerLevelIncrease(boardCell[i / 8][i % 8].content,
                                   boardCell[i / 8][i % 8].meaningContent,
                                   boardCell[i / 8][i % 8].oneFalseDone);
        boardCell[j / 8][j % 8].setPlace(true);
        msadb.leitnerLevelIncrease(boardCell[j / 8][j % 8].content,
                                   boardCell[j / 8][j % 8].meaningContent,
                                   boardCell[j / 8][j % 8].oneFalseDone);

        if (i / 16 == 0) {
            increaseFirstTowRow();
        } else if (i / 16 == 1) {
            increaseSecondTowRow();
        } else if (i / 16 == 2) {
            increaseThirdTowRow();
        } else if (i / 16 == 3) {
            increaseFourthTowRow();
        }
        if (j / 16 == 0) {
            increaseFirstTowRow();
        } else if (j / 16 == 1) {
            increaseSecondTowRow();
        } else if (j / 16 == 2) {
            increaseThirdTowRow();
        } else if (j / 16 == 3) {
            increaseFourthTowRow();
        }
    }

    void swap(int j1, int i1, int j2, int i2, boolean sameBoard) { //second is replaced in first
        int x, y;
        System.out.println("swaping: " + (j1 * 8 + i1) + "and" + (j2 * 8 + i2));
        if (sameBoard == true) {
            x = boardCell[j1][i1].getx();
            y = boardCell[j1][i1].gety();
            boardCell[j1][i1] = new cell(boardCell[j2][i2]);
            boardCell[j1][i1].setx(x);
            boardCell[j1][i1].sety(y);
        } else {
            x = boardCell[j1][i1].getx();
            y = boardCell[j1][i1].gety();
            boardCell[j1][i1] =new cell(boardCellBuffer[j2][i2]);
            boardCell[j1][i1].setx(x);
            boardCell[j1][i1].sety(y);

        }
    }

    boolean updateBoard() { // check four variables and new load
        System.out.println("fistTowRow is:" + firstTowRow + "secondTowRow is:" +
                           secondTowRow + "thirdTowRow" + thirdTowRow +
                           "fourthTowRow" + fourthTowRow);
        boolean sw = false;
        if (firstTowRow > 12) { // four undone is ok
            sw = true;
            if (bufferRow == 0) { // it means that buffer is empty
                fillBuffer();
            }
            for (int i = 0; i < 16; i++) {
                swap(i / 8, i %
                     8, (4 - bufferRow) * 2 +
                     i / 8, i % 8, false);
            }
            setFirstTowRow(); // nothing is matched and is new entered
            updateBufferRow();
        }
        if (secondTowRow > 12) { // four undone is ok
            sw = true;
            if (bufferRow == 0) { // it means that buffer is empty
                fillBuffer();
            }
            for (int i = 16; i < 32; i++) {
                swap(i / 8, i % 8, (i - 16) / 8, i % 8, true); //changing place of first Tow Row
            }
            for (int i = 0; i < 16; i++) {
                swap(i / 8, i %
                     8, (4 - bufferRow) * 2 +
                     i / 8, i % 8, false);
            }
            secondTowRow = firstTowRow;
            setFirstTowRow(); // nothing is matched and is new entered
            updateBufferRow();

        }
        if (thirdTowRow > 12) { // four undone is ok
            sw = true;
            if (bufferRow == 0) { // it means that buffer is empty
                fillBuffer();
            }
            for (int i = 32; i < 48; i++) {
                swap(i / 8, i % 8, (i - 16) / 8, i % 8, true); //changing place of first Tow Row
            }
            thirdTowRow = secondTowRow;
            for (int i = 16; i < 32; i++) {
                swap(i / 8, i % 8, (i - 16) / 8, i % 8, true); //changing place of first Tow Row
            }
            secondTowRow = firstTowRow;
            for (int i = 0; i < 16; i++) {
                swap(i / 8, i %
                     8, (4 - bufferRow) * 2 +
                     i / 8, i % 8, false);
            }
            setFirstTowRow(); // nothing is matched and is new entere
            updateBufferRow();
        }
        if (fourthTowRow > 12) { // four undone is ok
            sw = true;
            if (bufferRow == 0) { // it means that buffer is empty
                fillBuffer();
            }
            for (int i = 48; i < 64; i++) {
                swap(i / 8, i % 8, (i - 16) / 8, i % 8, true); //changing place of first Tow Row
            }
            fourthTowRow = thirdTowRow;
            for (int i = 32; i < 48; i++) {
                swap(i / 8, i % 8, (i - 16) / 8, i % 8, true); //changing place of first Tow Row
            }
            thirdTowRow = secondTowRow;
            for (int i = 16; i < 32; i++) {
                swap(i / 8, i % 8, (i - 16) / 8, i % 8, true); //changing place of first Tow Row
            }
            secondTowRow = firstTowRow;
            for (int i = 0; i < 16; i++) {
                swap(i / 8, i %
                     8, (4 - bufferRow) * 2 +
                     i / 8, i % 8, false);
            }
            setFirstTowRow(); // nothing is matched and is new entere
            updateBufferRow();
        }
        //and paint it again
        //paint();
        return sw;
    }

    int getMaxChange() {
        if (fourthTowRow > 12) {
            return 4;
        }
        if (thirdTowRow > 12) {
            return 3;
        }
        if (secondTowRow > 12) {
            return 2;
        }
        if (firstTowRow > 12) {
            return 1;
        }
        return 0; // means no change Occured
    }

    public static void main(String[] args) {
        board mainBoard = new board();
    }
}
