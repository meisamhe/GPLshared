//====
// CodeBreaker.hpp
// - defines the Mastermind CodeBreaker class
// Notes
// - this package is provided as is with no warranty.
// - the authors are not responsible for any damage caused
//   either directly or indirectly by using this package.
// - anybody is free to do whatever he/she wants with this
//   package as long as this header section is preserved.
// Created on 2003-02-06 by
// - Wayne Martin
// - Roger Zhang (r_zhang@cs.smu.ca)
// Modifications
// - Roger Zhang on 2004-11-11
//   - changed internal code list to map
//   - removed complicated code coupling
//   - added methods to facilitate simulations
// -
// Last compiled under Linux with gcc-3
//====

#ifndef _MM_CODE_BREAKER_
#define _MM_CODE_BREAKER_

#include "Player.hpp"
#include <map>

namespace MM
{
    class CodeBreaker : public Player
    {
        int tries_;

        std::map<Code, bool> codes_;

        // assignment operation is not allowed
        CodeBreaker &operator =(const CodeBreaker&) { return *this; }

    public:

        CodeBreaker(
            int colors, int length
        ) : Player(colors, length), tries_(0) { reset(); }

        // construct with a given starting guess, for simulations only
        CodeBreaker(const Code &c) : Player(c), tries_(0) { reset(true); }

        // true when wrong score has been detected
        bool trapped() const { return tries_ < 0; }

        // note: if wrong score detected, "score" set to -1
        void play(/* out */ std::string &guess, /* inout */ int &score);

        void reset(bool noRandom = false);

    }; // class CodeBreaker

} // namespace MM

#endif // _MM_CODE_BREAKER_
