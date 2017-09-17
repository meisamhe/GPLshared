// Copyright (c) 2013 Elements of Programming Interviews. All rights reserved.

#include <algorithm>
#include <cassert>
#include <iostream>
#include <limits>
#include <memory>

#include "./Binary_tree_prototype.h"

using std::cout;
using std::endl;
using std::make_unique;
using std::numeric_limits;
using std::unique_ptr;

// @include
bool HasPathSum(const unique_ptr<BinaryTreeNode<int>>& tree,
                int remaining_weight) {
  if (tree == nullptr) {
    return false;
  } else if (tree->left == nullptr && tree->right == nullptr) {  // Leaf.
    return remaining_weight == tree->data;
  }
  // Non-leaf.
  return HasPathSum(tree->left, remaining_weight - tree->data) ||
         HasPathSum(tree->right, remaining_weight - tree->data);
}
// @exclude

int main(int argc, char** argv) {
  //      3
  //    2   5
  //  1    4 6
  unique_ptr<BinaryTreeNode<int>> tree = make_unique<BinaryTreeNode<int>>(
      BinaryTreeNode<int>{3, nullptr, nullptr});
  assert(HasPathSum(tree, 3));
  tree->left = make_unique<BinaryTreeNode<int>>(
      BinaryTreeNode<int>{2, nullptr, nullptr});
  assert(HasPathSum(tree, 5));
  tree->left->left = make_unique<BinaryTreeNode<int>>(
      BinaryTreeNode<int>{1, nullptr, nullptr});
  assert(HasPathSum(tree, 6));
  tree->right = make_unique<BinaryTreeNode<int>>(
      BinaryTreeNode<int>{5, nullptr, nullptr});
  assert(HasPathSum(tree, 8));
  assert(!HasPathSum(tree, 7));
  tree->right->left = make_unique<BinaryTreeNode<int>>(
      BinaryTreeNode<int>{4, nullptr, nullptr});
  assert(HasPathSum(tree, 12));
  assert(!HasPathSum(tree, 1));
  assert(!HasPathSum(tree, 3));
  assert(!HasPathSum(tree, 5));
  tree->right->right = make_unique<BinaryTreeNode<int>>(
      BinaryTreeNode<int>{6, nullptr, nullptr});
  assert(HasPathSum(tree, 6));
  assert(!HasPathSum(tree, 7));
  assert(HasPathSum(tree, 14));
  assert(!HasPathSum(tree, -1));
  assert(!HasPathSum(tree, numeric_limits<int>::max()));
  assert(!HasPathSum(tree, numeric_limits<int>::min()));
  return 0;
}
