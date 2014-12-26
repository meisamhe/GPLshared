//====
// Code.cpp
// - implements some functions declared in Code.hpp
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
//   - fixed some efficiency flaws
// -
// Last compiled under Linux with gcc-3
//====

#include "Code.hpp"
#include <cassert>
#include <ctime>

namespace MM
{
    Code::Code(int colors, int length) : overflow_(false),
        totalColors_(colors), uniqueColors_(1)
    {
        assert(colors >= 2 && colors <= 10);
        assert(length >= 1 && length <= 5 /* for efficiency */);

        if (colors == 10) {
            min_ = '0', max_ = '9';
        } else {
            min_ = '1', max_ = char(colors + 48);
        }

        value_.assign(length, min_);
    }

    void Code::computeUC()
    {
        uniqueColors_ = value_.length();

        for (register int i = 1; i < value_.length(); ++i) {
            for (register int j = 0; j < i; ++j) {
                if (value_[i] == value_[j] && --uniqueColors_) {
                    break;
                }
            }
        }
    }

    int Code::score(const Code &c) const
    {
        std::string tempValue = c.value_;
        register int exact = 0, total = 0;

        // calculate number of exact matches
        for (register int i = 0; i < value_.length(); ++i) {
            exact += (tempValue[i] == value_[i]);
        }

        // calculate total matches
        for (register int j = 0; j < value_.length(); ++j) {
            for (register int k = 0; k < value_.length(); ++k) {
                if (value_[j] == tempValue[k] && ++total) {
                    // avoid double counting in the rest
                    // iterations of the outermost loop
                    tempValue[k] = 'X';
                    // avoid double counting in the
                    // following iterations of this loop
                    break;
                }
            }
        }

        return exact * 10 + total - exact;
    }

    void Code::generate()
    {
        srand(time(NULL));

        uniqueColors_ = value_.length(); // assume this for now

        for (register int i = 0; i < value_.length(); ++i) {
            // '0' will only be used when we have 10 colors
            value_[i] = char(rand() % totalColors_ + min_);

            for (register int j = 0; j < i; ++j) {
                if (value_[i] == value_[j] && uniqueColors_--) {
                    break;
                }
            }
        }

        overflow_ = false;
    }

    void Code::setValue(const std::string &v)
    {
        assert(v.length() == value_.length());

        uniqueColors_ = value_.length(); // assume this for now

        // every color must be within the current color range
        for (register int i = 0; i < v.length(); ++i) {
            assert(v[i] >= min_ && v[i] <= max_);
            value_[i] = v[i];
            for (register int j = 0; j < i; ++j) {
                if (value_[i] == value_[j] && uniqueColors_--) {
                    break;
                }
            }
        }

        overflow_ = false;
    }

    Code &Code::operator =(const Code &c)
    {
        totalColors_ = c.totalColors_;
        uniqueColors_ = c.uniqueColors_;
        value_ = c.value_;
        overflow_ = false;
        min_ = c.min_;
        max_ = c.max_;

        return *this;
    }

    Code &Code::operator ++()
    {
        register int i = value_.length();

        while (--i >= 0 && ++value_[i] > max_ && (value_[i] = min_));

        overflow_ = i < 0;

        computeUC();

        return *this;
    }

    Code &Code::operator --()
    {
        register int i = value_.length();

        while (--i >= 0 && --value_[i] < min_ && (value_[i] = max_));

        overflow_ = i < 0;

        computeUC();

        return *this;
    }

} // namespace MM
