import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gravytea/common/constants.dart';
import 'package:gravytea/model/acceleration.dart';
import 'package:gravytea/model/planet_dto.dart';
import 'package:gravytea/model/velocity.dart' as velocity;

class Physics {
  static Acceleration gravityAcceleration(PlanetDTO planet1, PlanetDTO planet2, double forceFactor,
      double forceDistanceFactor, double repelFactor, bool attractive) {
    double distance = planet1.position.distanceTo(planet2.position);
    double forceField = pow(10, forceFactor).toDouble() * planet2.mass / pow(distance, forceDistanceFactor);
    if (!attractive) {
      forceField = - forceField;
    }
    double xDiff = (planet2.position.x - planet1.position.x).toDouble();
    double yDiff = (planet2.position.y - planet1.position.y).toDouble();
    double phi = atan(yDiff / xDiff);
    if (planet2.position.x < planet1.position.x) {
      phi += pi;
    }
    double xComponent = forceField * cos(phi);
    double yComponent = forceField * sin(phi);
    if (distance <= Constants.bodyRadius) {
      return Acceleration(-xComponent * repelFactor, -yComponent * repelFactor);
    }
    return Acceleration(xComponent, yComponent);
  }

  static velocity.Velocity newVelocity(
      PlanetDTO planet, double ips, Acceleration resultAcceleration, Size dimensions, double wallDamp) {
    double time = 1 / ips;
    double newX = planet.velocity.x;
    double newY = planet.velocity.y;

    newX += resultAcceleration.x * time;
    newY += resultAcceleration.y * time;

    if (planet.position.x <= Constants.bodyRadius || planet.position.x >= (dimensions.width - Constants.bodyRadius)) {
      newX = -newX * (1 - wallDamp);
    }
    if (planet.position.y <= Constants.bodyRadius || planet.position.y >= (dimensions.height - Constants.bodyRadius)) {
      newY = -newY * (1 - wallDamp);
    }
    return velocity.Velocity(newX, newY);
  }

  static Point newPosition(PlanetDTO planet, double ips, Size dimensions) {
    double time = 1 / ips;
    double newX = planet.position.x + planet.velocity.x * time;
    double newY = planet.position.y + planet.velocity.y * time;
    if (planet.position.x <= Constants.bodyRadius || planet.position.x >= (dimensions.width - Constants.bodyRadius)) {
      newX = planet.position.x - planet.velocity.x * time;
    }
    if (planet.position.y <= Constants.bodyRadius || planet.position.y >= (dimensions.height - Constants.bodyRadius)) {
      newY = planet.position.y - planet.velocity.y * time;
    }
    return Point(newX, newY);
  }

  static List<PlanetDTO> calculateNextState(List<PlanetDTO> planets, double ips, double forceFactor,
      double forceDistanceFactor, double repelFactor, Size dimensions, double wallDamp, bool attractive) {
    List<PlanetDTO> resultList = List.empty(growable: true);
    for (PlanetDTO referent in planets) {
      List<PlanetDTO> otherPlanets = planets.toList();
      otherPlanets.remove(referent);
      Acceleration resultAcceleration = Acceleration(0, 0);
      for (PlanetDTO other in otherPlanets) {
        Acceleration acceleration =
            gravityAcceleration(referent, other, forceFactor, forceDistanceFactor, repelFactor, attractive);
        resultAcceleration.add(acceleration);
      }
      PlanetDTO newValue = PlanetDTO(
          mass: referent.mass,
          position: newPosition(referent, ips, dimensions),
          velocity: newVelocity(referent, ips, resultAcceleration, dimensions, wallDamp));
      resultList.add(newValue);
    }
    return resultList;
  }
}
