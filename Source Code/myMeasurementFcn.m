function z = myMeasurementFcn(x)
    % x: state vector [gap; velocity]

    % Measurement function outputs observed sensor values

    % Extract states
    gap = 0.001;
    velocity = 0;

    % Measurement vector
    z = [gap; velocity];
end
