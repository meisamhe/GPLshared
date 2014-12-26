//====
// mbfs.cpp
// - Mastermind brute force simulation
// - usage: mbfs <num_colors> <code_length> <num_tries>
//   where <num_colors> is the number of available colors,
//   <code_length> is the number of pegs a code has, and
//   <num_tries> is the maximum number of guesses allowed.
// - this program iterates on all possible situations,
//   for example, if <num_colors> is 8, <code_length> is 4,
//   and <num_tries> is 8, then there will be a total of
//   4096 codes, and 4096 possible starting guesses, hence
//   the code maker will test all 4096 codes, and for each
//   code the code breaker will make 4096 attempts, each
//   starting from a different guess. the program records
//   all final results, and sends them to standard output.
// Notes
// - this program is provided as is with no warranty.
// - the author is not responsible for any damage caused
//   either directly or indirectly by using this program.
// - anybody is free to do whatever he/she wants with this
//   program as long as this header section is preserved.
// Created on 2004-11-12 by
// - Roger Zhang (rogerz@cs.dal.ca)
// Modifications
// - Roger Zhang on 2004-11-15
//   - changed output format to reflect success or failure
// -
// Last compiled under Linux with gcc-3
//====

#include "CodeBreaker.hpp"
#include "CodeMaker.hpp"
#include <iostream>
#include <iomanip>
#include <cstdlib>
#include <cassert>
#include <cmath>

using namespace MM;
using namespace std;

int main(int argc, char *argv[])
{
    if (argc != 4) {
        cerr << "usage:\t" << argv[0]
             << " <num_colors> <code_length> <num_tries>\n";
        return 1;
    }

    int numColors = atoi(argv[1]);
    int codeLength = atoi(argv[2]);
    int numTries = atoi(argv[3]);
    int winningScore = codeLength * 10;

    assert(numColors >= 2 && numColors <= 10);
    assert(codeLength > 0 && codeLength <= 5);
    assert(numTries > 0);

    int success = 0, total = int(pow(double(numColors), codeLength * 2));

    cout << "initial guess\tsecret code\tstatus\n"
         << "=============\t===========\t======\n";
    cout.setf(ios::left, ios::adjustfield);

    CodeMaker coder(numColors, codeLength);
    CodeBreaker guesser(numColors, codeLength);

    for (Code g(numColors, codeLength); !g.overflow(); ++g) {

        for (Code c(numColors, codeLength); !c.overflow(); ++c) {

            guesser.startWith(g);
            coder.startWith(c);

            //====
            // turn this line on for debugging
            // cerr << "secret code: " << string(c) << endl;

            string guess;
            int score = 0;

            for (int i = 0; i < numTries; i++) {

                guesser.play(guess, score);
                coder.play(guess, score);

                //====
                // turn this line on for debugging
                // cerr << guess << " " << score << endl;

                if (score == winningScore && ++success) {
                    break;
                }
            }

            cout << "    " << setw(9) << string(g)
                 << "\t   " << setw(8) << string(c) << "\t  "
                 << (score == winningScore ? "S" : "F") << endl;

            guesser.reset(true);
        }
    }

    cout << "=============\t===========\t======\n"
         << "total success\t   " << success
         << "\ntotal failure\t   " << total - success
         << "\nsuccess ratio\t   " << 100 * success / double(total) << "%\n";

    return 0;
}
