library utils;

import 'dart:math';

// TODO: better name?

Random rnd = Random();

// TODO: break into 2 functions?
/// ex: maxRandomFactor = 0.70 will give Random number between -0.70 and 0.70
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
