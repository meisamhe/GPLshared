//====
// Code.hpp
// - defines the Mastermind Code class
// Notes
// - this package is provided as is with no warranty.
// - the authors are not responsible for any damage caused
//   either directly or indirectly by using this package.
// - anybody is free to do whatever he/she wants with this
//   package as long as this header section is preserved.
// Created on 2003-01-31 by
// - Wayne Martin
// - Roger Zhang (r_zhang@cs.smu.ca)
// Modifications
// - Roger Zhang on 2004-11-10
//   - fixed a few efficiency flaws
//   - added the comparison operators
// - Roger Zhang on 2004-11-12
//   - added the compatible function to facilitate simulations
// -
// Last compiled under Linux with gcc-3
//====

#ifndef _MM_CODE_
#define _MM_CODE_

#include <string>

namespace MM // MM stands for MasterMind :)
{
    class Code
    {
        //====
        // data members

        std::string value_; // "1234", for example

        char min_, max_; // for example, '1' and '8' for 8 colors

        int totalColors_, uniqueColors_;

        // set by operators ++ and -- if the operation has caused a
        // wrap-around-the-end situation, for example, with 8 colors
        // incrementing "8888" results in "1111", while decrementing
        // "1111" gets back "8888". the flag is cleared by the next
        // operation (whatever it might be) that updates "value_"
        bool overflow_;

        void computeUC(); // update "uniqueColors_"

    public:

        //====
        // constructors

        // "colors" must be in the range [2, 10]
        // "length" must be in the range [1, 5]
        Code(int colors = 8, int length = 4);

        Code(const Code &c) : value_(c.value_), min_(c.min_),
            max_(c.max_), totalColors_(c.totalColors_),
            uniqueColors_(c.uniqueColors_), overflow_(false) {}

        //====
        // accessors and mutators

        bool overflow() const { return overflow_; }

        bool compatible(const Code &c) const
        {
            return totalColors_ == c.totalColors_ &&
                   value_.length() == c.value_.length();
        }

        int totalColors() const { return totalColors_; }

        int uniqueColors() const { return uniqueColors_; }

        // return the score against "c", for example, return 12 if
        // this Code is "1234" and "c" is "2731". for efficiency,
        // integer scores are used, thus a score 3 really means 03
        int score(const Code &c) const;

        void generate(); // generate a random "value_"

        void setValue(const std::string &v);

        //====
        // operator overloads

        // set "value_" to the next valid value according to Code length
        // and "colors_", for example, with 8 colors, the length 4 Code
        // "1234" will become "1235", and "3458" will become "3461".
        Code &operator ++(); // for efficiency, no suffix version

        Code &operator --(); // operator ++ reversed

        Code &operator =(const Code &c);

        // these are added just to make some STL functions happy :)
        bool operator <(const Code &c) const { return value_ < c.value_; }
        bool operator >(const Code &c) const { return value_ > c.value_; }
        bool operator <=(const Code &c) const { return value_ <= c.value_; }
        bool operator >=(const Code &c) const { return value_ >= c.value_; }
        bool operator ==(const Code &c) const { return value_ == c.value_; }
        bool operator !=(const Code &c) const { return value_ != c.value_; }

        operator std::string() const { return (const std::string&)value_; }

    }; // class Code

} // namespace MM

#endif // _MM_CODE_
