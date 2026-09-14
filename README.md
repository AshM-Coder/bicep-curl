# Bicep Curl Biomechanics: Static and Dynamic Analysis

MATLAB models of the forearm during a bicep curl, starting from a static free-body analysis and extending to a full dynamic simulation with a muscle-driven animation.

## Overview

The system: a forearm segment pivoting at the elbow (point O), with its own weight acting through its centre of mass (point A) and a carried weight held in the hand (point B). Two models are built up:

1. **Static model** — treats the joint moment as an unknown quantity exerted directly at the elbow, and solves for the reaction forces and bending moment as the arm is held at different angles.
2. **Dynamic model** — replaces the abstract joint moment with an actual muscle spanning the upper arm and forearm, drives the arm through simple harmonic motion (as in repeated curls), and computes the time-varying muscle force and reaction forces this requires.

## Files

- **`static_reaction_forces.m`** — prompts for an arm angle and reports the parallel/perpendicular reaction forces and bending moment at the elbow, derived from a static force and moment balance.
- **`dynamic_biceps_curl_animation.m`** — prompts for a range-of-motion angle, a repetition rate, and a carried weight mass, then simulates and animates the resulting joint kinematics (θ, ω, α), the muscle force, and the reaction forces over a 30-second window, with four plots updating in sync alongside the arm animation.

## Method notes

- The dynamic model assumes simple harmonic motion for the joint angle, with angular velocity and acceleration derived analytically by differentiation.
- Muscle force and reaction force expressions come from a dynamic force/moment balance on the forearm-plus-weight system, expressed in terms of the muscle's two attachment points on the upper arm and forearm.
- The moment of inertia and centre-of-mass location of the moving segment are approximated as empirical functions of the carried weight's mass.
- The animation renders the arm segment, the carried weight, and the muscle simultaneously with four synchronised time-series subplots (θ, R_parallel, R_perpendicular, F_muscle), all driven by a single shared time loop.

## Running it

Requires MATLAB (no additional toolboxes). Open either script and click **Run**, or call it from the command window:

```matlab
static_reaction_forces
dynamic_biceps_curl_animation
```

Each script will prompt for the required inputs in the command window.

## License

MIT — see `LICENSE`.
