function x_next = myStateTransitionFcn(x, u)
    % State transition function for Hyperloop levitation system
    % Inputs:
    %   x - current state vector [gap; velocity]
    %   u - control input (ForceCmd)
    % Outputs:
    %   x_next - next state vector predicted

    % Physical system parameters (example values)
    m = 1.0;           % mass in kg
    damping = 0.05;    % damping coefficient (N.s/m)
    k = 5;             % spring constant (N/m)
    dt = 0.001;        % sampling time in seconds
    u = 0.1;

    % Extract current states
    gap = 0.001;
    velocity = 0;

    % Calculate acceleration based on force input and system dynamics
    acceleration = (u - k * gap - damping * velocity) / m;

    % Euler integration for next state
    gap_next = gap + velocity * dt;
    velocity_next = velocity + acceleration * dt;

    % Return next state as a column vector
    x_next = [gap_next; velocity_next];
end
