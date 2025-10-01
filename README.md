# Intelligent-Sensor-fusion-for-Hyperloop-pod-levitation

# Intelligent Sensor Fusion for Hyperloop Pod Levitation

This project presents a **simulation-based intelligent sensor fusion and fault-tolerant control system** for **Hyperloop pod electromagnetic levitation**. Using **MATLAB/Simulink**, the system integrates multiple virtual sensors, applies **Extended Kalman Filter (EKF)-based fusion**, and introduces **fault injection models** to enhance reliability, safety, and performance in next-generation high-speed transportation systems.

---

## Project Overview

* **Objective**: Develop a **fault-tolerant sensor fusion and control system** for Hyperloop levitation.
* **Platform**: MATLAB/Simulink simulation with modular architecture.
* **Focus Areas**:

  * Multi-sensor fusion (accelerometer, proximity, magnetic field, pressure).
  * Fault injection & detection (bias, drift, spikes, dropouts).
  * EKF-based state estimation and robust levitation control.
  * Comparison of **multi-sensor fusion vs. single-sensor approaches**.

---

## System Architecture

The Simulink model consists of five major subsystems:

1. **Pod Dynamics** – models physical pod motion using electromagnetic and gravitational forces.
2. **Virtual Sensors** – generates sensor outputs (accelerometer, pressure, proximity, magnetic field).
3. **Noise & Fault Injection** – introduces realistic disturbances and sensor faults.
4. **Sensor Fusion (EKF)** – fuses noisy data for accurate levitation gap estimation.
5. **Controller** – applies PD control to maintain stable levitation, with fault-aware adjustments.

---

## Methodology

* **Mathematical Models**: Based on Newton’s laws and electromagnetic force equations.
* **Sensor Fusion**: Extended Kalman Filter (EKF) for nonlinear state estimation.
* **Fault Detection**: Innovation residuals to detect anomalies within 50–100 ms.
* **Control Strategy**: PID/PD controller with adaptive fault tolerance.
* **Simulation Scenarios**:

  * Nominal (no faults).
  * Fault-injected (bias, drift, spikes, dropout).
  * Load variations and noise increase.

---

## Results

* **Estimation Accuracy**: Fusion reduced mean squared error by **30–50%** vs. single sensors.
* **Fault Tolerance**: Faults detected and isolated within **50–100 ms**.
* **Control Stability**: Robust levitation maintained under disturbances.
* **Performance Metrics**: Rise time, overshoot, settling time, steady-state error validated system reliability.

---

## Future Work

* Hardware-in-the-Loop (HIL) and experimental validation.
* Machine learning–based fault detection (neural networks, SVMs).
* Predictive and adaptive control (e.g., MPC).
* Full multi-axis pod dynamics modeling (6-DOF).
* Integration with V2X communication for cooperative fault tolerance.
* Optimization for real-time embedded deployment.

