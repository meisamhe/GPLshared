// Copyright (c) 2016 Elements of Programming Interviews. All rights reserved.

#ifndef SOLUTIONS_CPP_MAGIC_MAZE_GAME_H_
#define SOLUTIONS_CPP_MAGIC_MAZE_GAME_H_

#include "./maze-game.h"

class MagicRoom : public Room {
 public:
  virtual ~MagicRoom() override = default;

  void Connect(const Room* that) override {}
};

// @include
class MagicMazeGameCreator : public MazeGameCreator {
  // @exclude
 public:
  virtual ~MagicMazeGameCreator() override = default;
  // @include
  Room* MakeRoom() override { return new MagicRoom(); }
};
// @exclude

#endif  // SOLUTIONS_CPP_MAGIC_MAZE_GAME_H_
