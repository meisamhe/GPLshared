//====
// CodeMaker.hpp
// - defines the Mastermind CodeMaker class
// Notes
// - this package is provided as is with no warranty.
// - the authors are not responsible for any damage caused
//   either directly or indirectly by using this package.
// - anybody is free to do whatever he/she wants with this
//   package as long as this header section is preserved.
// Created on 2003-02-05 by
// - Wayne Martin
// - Roger Zhang (r_zhang@cs.smu.ca)
// Modifications
// - Roger Zhang on 2004-11-12
//   - removed complicated code coupling
//   - added methods to facilitate simulations
// -
// Last compiled under Linux with gcc-3
//====

#ifndef _MM_CODE_MAKER_
#define _MM_CODE_MAKER_

#include "Player.hpp"

namespace MM
{
    class CodeMaker : public Player
    {
        // assignment operation is not allowed
        CodeMaker &operator =(const CodeMaker&) { return *this; }

    public:

        CodeMaker(int colors, int length) : Player(colors, length)
        {
            reset();
        }

        // construct from a given code, for simulations only
        CodeMaker(const Code &c, int tries) : Player(c) {}

        std::string code() const
        {
            return code_->operator std::string();
        }

        void play(/* in */ std::string &guess, /* out */ int &score)
        {
            Code temp(*code_);
            temp.setValue(guess);
            score = code_->score(temp);
        }

        void reset(bool noRandom = false)
        {
            if (!noRandom) {
                code_->generate();
            }
        }

    }; // class CodeMaker

} // namespace MM

#endif // _MM_CODE_MAKER_
