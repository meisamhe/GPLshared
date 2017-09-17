// Copyright (c) 2017 Elements of Programming Interviews. All rights reserved.

#include <algorithm>
#include <cassert>
#include <iostream>
#include <random>
#include <stack>
#include <string>
#include <vector>

using std::cout;
using std::default_random_engine;
using std::endl;
using std::max;
using std::stack;
using std::string;
using std::random_device;
using std::uniform_int_distribution;
using std::vector;

// @include
int LongestValidParentheses(const string& s) {
  int max_length = 0, end = -1;
  stack<int> left_parentheses_indices;
  for (int i = 0; i < s.size(); ++i) {
    if (s[i] == '(') {
      left_parentheses_indices.emplace(i);
    } else if (left_parentheses_indices.empty()) {
      end = i;
    } else {
      left_parentheses_indices.pop();
      int start = left_parentheses_indices.empty()
                      ? end
                      : left_parentheses_indices.top();
      max_length = max(max_length, i - start);
    }
  }
  return max_length;
}
// @exclude

template <typename IterType>
int ParseFromSide(char paren, IterType begin, IterType end) {
  int max_length = 0, num_parens_so_far = 0, length = 0;
  for (IterType i = begin; i < end; ++i) {
    if (*i == paren) {
      ++num_parens_so_far, ++length;
    } else {  // *i != paren
      if (num_parens_so_far <= 0) {
        num_parens_so_far = length = 0;
      } else {
        --num_parens_so_far, ++length;
        if (num_parens_so_far == 0) {
          max_length = max(max_length, length);
        }
      }
    }
  }
  return max_length;
}

int LongestValidParenthesesConstantSpace(const string& s) {
  return max(ParseFromSide('(', begin(s), end(s)),
             ParseFromSide(')', s.rbegin(), s.rend()));
}

void SmallTest() {
  assert(LongestValidParentheses(")(((())()(()(") == 6);
  assert(LongestValidParentheses("((())()(()(") == 6);
  assert(LongestValidParentheses(")(") == 0);
  assert(LongestValidParentheses("()") == 2);
  assert(LongestValidParentheses("") == 0);
  assert(LongestValidParentheses("()()())") == 6);
  assert(LongestValidParenthesesConstantSpace(")(((())()(()(") == 6);
  assert(LongestValidParenthesesConstantSpace("((())()(()(") == 6);
  assert(LongestValidParenthesesConstantSpace(")(") == 0);
  assert(LongestValidParenthesesConstantSpace("()") == 2);
  assert(LongestValidParenthesesConstantSpace("") == 0);
  assert(LongestValidParenthesesConstantSpace("()()())") == 6);
}

string RandString(int length) {
  default_random_engine gen((random_device())());
  string result;
  while (length--) {
    uniform_int_distribution<int> left_or_right(0, 1);
    result += left_or_right(gen) ? '(' : ')';
  }
  return result;
}

int main(int argc, char** argv) {
  SmallTest();
  if (argc == 2) {
    string s = argv[1];
    cout << "s = " << s << endl;
    cout << LongestValidParentheses(s) << endl;
  } else {
    default_random_engine gen((random_device())());
    uniform_int_distribution<int> dis(0, 100000);
    for (int times = 0; times < 1000; ++times) {
      string s = RandString(dis(gen));
      assert(LongestValidParenthesesConstantSpace(s) ==
             LongestValidParentheses(s));
    }
  }
  return 0;
}
