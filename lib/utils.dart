library utils;

import 'dart:math';

// TODO: better name?

Random rnd = Random();

double nextDoubleFromMinusFactorToFactor(double maxRandomFactor) {
  double randomFactor = maxRandomFactor >= 1
      ? rnd.nextDouble()
      : rnd.nextDouble() * maxRandomFactor;
  return rnd.nextInt(2) == 0 ? randomFactor : -randomFactor;
}

//  static double nextDoubleBetweenZeroAndMax(double max) =>
//      max >= 1 ? rnd.nextDouble() : rnd.nextDouble() * max;

// includes both min and max
int getRandomInt(int min, int max) =>
    (rnd.nextDouble() * (max - min + 1)).floor() + min;
