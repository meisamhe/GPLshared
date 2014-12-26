//====
// CodeBreaker.cpp
// - implements the Mastermind CodeBreaker class
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
//   - fixed a few efficiency flaws
//   - removed complicated code coupling
// -
// Last compiled under Linux with gcc-3
//====

#include "CodeBreaker.hpp"

namespace MM
{
    typedef std::map<Code, bool>::iterator MapIter;

    void CodeBreaker::play(std::string &guess, int &score)
    {
        if (tries_ < 0) {
            return;
        }

        if (tries_++) { // otherwise it's the first guess

            register int maxUnique = 0;

            MapIter i, bestIndex = codes_.end();

            for (i = codes_.begin(); i != codes_.end(); i++) {
                if (i->second) { // otherwise i->first can't be the code
                    i->second = i->first.score(*code_) == score;
                    if (i->second && i->first.uniqueColors() > maxUnique) {
                        maxUnique = i->first.uniqueColors();
                        bestIndex = i; // record the best candidate so far
                    }
                }
            }

            if (!maxUnique) { // one or more previous scores must be wrong
                tries_ = -1;
            } else {
                *code_ = bestIndex->first;
            }
        }

        guess = code_->operator std::string();
    }

    void CodeBreaker::reset(bool noRandom)
    {
        if (codes_.empty()) {
            for (Code c(*code_); !c.overflow() && (codes_[c] = true); ++c);
        } else {
            for (MapIter i = codes_.begin(); i != codes_.end(); ++i) {
                i->second = true;
            }
        }

        if (!noRandom) {
            code_->generate();
        }

        tries_ = 0;
    }

} // namespace MM
