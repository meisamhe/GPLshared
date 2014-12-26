//====
// mcui.cpp
// - Mastermind console user interface
// - serves as a test harness for the MM components
// Notes
// - this program is provided as is with no warranty.
// - the author is not responsible for any damage caused
//   either directly or indirectly by using this program.
// - anybody is free to do whatever he/she wants with this
//   program as long as this header section is preserved.
// Created on 2003-02-09 by
// - Roger Zhang (r_zhang@cs.smu.ca)
// Modifications
// -
// Last compiled under Linux with gcc-3
//====

#include "CodeMaker.hpp"
#include "CodeBreaker.hpp"
#include <iostream>

using namespace MM;
using namespace std;

void getLevel(int &tries, int &colors, int &length)
{
    int level;
    cout << "\nPlease select one of the following difficulty levels:\n"
         << "1-Easy, 2-Normal, 3-Hard, 0-Custom. Enter your choice: ";
    cin >> level;

    if (level == 0) {
        cout << "\nPlease enter number of tries here: ";
        cin >> tries;
        cout << "\nPlease enter number of colors [2 - 10] here: ";
        cin >> colors;
        cout << "Please enter length of code [1 - 5] here: ";
        cin >> length;
    } else {
        tries = 10;
        length = level + 2;
        colors = length * 2;
    }
}

int main()
{
    cout << "============= Welcome to Mastermind =============" << endl;

    string userOption;

start:

    cout << "\nPlay Code Maker, Code Breaker, or Quit? [M/B/Q] ";
    cin >> userOption;

    if (userOption == "Q" || userOption == "q") {
        cout << "\n========= Thanks for Playing Mastermind =========\n";
        return 0;
    } else if (userOption != "M" && userOption != "m" &&
               userOption != "B" && userOption != "b") {
        cout << "Sorry, invalid response. Let's try again.";
        goto start;
    } else {
        string guess;
        Player *rival;
        bool userIsCB = (userOption == "B" || userOption == "b");
        int score, maxTries, numColors, codeLength;

        getLevel(maxTries, numColors, codeLength);

        do {
            if (userIsCB) {
                rival = new CodeMaker(numColors, codeLength);
            } else {
                rival = new CodeBreaker(numColors, codeLength);
            }

            do {
                cout << endl;
                for (int tries = 1; tries <= maxTries; tries++) {
                    if (userIsCB) {
                        cout << "Please enter you guess #"
                             << tries << " here: ";
                        cin >> guess;
                    }
                    rival->play(guess, score);

                    if (userIsCB) {
                        cout << "Your score is: "
                             << (score < 10 ? "0" : "") << score << endl;
                    } else {
                        if (((CodeBreaker*)rival)->trapped()) {
                            cout << "\nYou must have entered "
                                 << "as least one wrong score.\n";
                            break;
                        } else {
                            cout << "My guess #" << tries << " is: "
                                 << guess << "\nPlease enter my score: ";
                            cin >> score;
                        }
                    }

                    if (score == guess.length() * 10) {
                        cout << "\nCongratulations"
                             << (userIsCB ? "!\nYou" : " to me!\nI")
                             << " solved it in " << tries
                             << (tries > 1 ? " tries." : " try.") << endl;
                        break;
                    }
                }

                if (score != guess.length() * 10) {
                    if (userIsCB) {
                        cout << "\nYou have run out your tries."
                             << "\nThe secret code is: " << guess << endl;
                    } else {
                        cout << "\nOops, I have run out my tries."
                             << "\nI'll beat you next time!\n";
                    }
                }

                cout << "\nPlay again? [Y/N] ";
                cin >> userOption;
                score = 0;
                rival->reset();
            } while (userOption == "Y" || userOption == "y");

            delete rival;

            cout << "\nSwitch roles and play again, "
                 << "or Return to main menu? [S/R] ";
            cin >> userOption;
            userIsCB ^= (userOption == "S" || userOption == "s");
        } while (userOption != "R" && userOption != "r");
    }

    goto start;
}
