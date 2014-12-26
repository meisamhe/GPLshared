//====
// Player.hpp
// - defines the Mastermind Player abstract class
// Notes
// - this package is provided as is with no warranty.
// - the authors are not responsible for any damage caused
//   either directly or indirectly by using this package.
// - anybody is free to do whatever he/she wants with this
//   package as long as this header section is preserved.
// Created on 2003-02-03 by
// - Wayne Martin
// - Roger Zhang (r_zhang@cs.smu.ca)
// Modifications
// - Roger Zhang on 2004-11-12
//   - removed complicated code coupling
//   - added methods to facilitate simulations
// -
// Last compiled under Linux with gcc-3
//====

#ifndef _MM_PLAYER_
#define _MM_PLAYER_

#include "Code.hpp"
#include <cassert>
#include <string>

namespace MM
{
    class Player // abstract
    {

    protected:

        Code *code_; // secret code for coder, guess for code breaker

    public:

        Player(int colors, int length) : code_(new Code(colors, length)) {}

        // construct with a given code, for simulations only
        Player(const Code &c) : code_(new Code(c)) {}

        virtual ~Player() { delete code_; }

        void startWith(const Code &c) // for simulations only
        {
            assert(code_->compatible(c));
            *code_ = c;
        }

        virtual void play(std::string &guess, int &score) = 0;

        virtual void reset(bool noRandom = false) = 0;

    }; // class Player

} // namespace MM

#endif // _MM_PLAYER_
