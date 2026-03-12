% --- Parameters for Fault Simulation ---
t_fault_start = 5;          % Time (seconds) to inject fault
fault_duration = 10;        % Duration of fault (seconds)
bias_value = 0.005;         % Fault: bias added to sensor
noise_fault_std = 0.002;    % Fault: increased noise std dev

% --- Simulated sensor signal (example: estimated gap) ---
t = gapWS.time; 
sensor_signal = GapEstWS.signals.values(:,1);  % Assume 1st sensor estimate

% --- Ensure t and sensor_signal lengths match by interpolation ---
param_sensor = linspace(0, 1, length(sensor_signal));
param_t = linspace(0, 1, length(t));
sensor_signal_interp = interp1(param_sensor, sensor_signal, param_t);

% --- Initialize faulty sensor array ---
sensor_faulty = sensor_signal_interp;

% Inject faults in time window
fault_indices = find(t >= t_fault_start & t <= t_fault_start + fault_duration);

% Ensure fault_indices is a column vector
fault_indices = fault_indices(:);

% Inject bias fault if fault_indices non-empty
if ~isempty(fault_indices)
    sensor_faulty(fault_indices) = sensor_faulty(fault_indices) + bias_value;
end

% Inject noise fault (Gaussian noise), carefully ensure size and orientation match
if ~isempty(fault_indices)
    noise_vector = noise_fault_std * randn(length(fault_indices), 1);

    % Extract sensor segment and ensure column orientation
    sensor_segment = sensor_faulty(fault_indices);
    if isrow(sensor_segment)
        sensor_segment = sensor_segment';
    end

    % Add noise
    sensor_segment = sensor_segment + noise_vector;

    % Assign back with orientation matching sensor_faulty
    if isrow(sensor_faulty)
        sensor_faulty(fault_indices) = sensor_segment';
    else
        sensor_faulty(fault_indices) = sensor_segment;
    end
end

% --- Fault Detection: Innovation residual ---
% Using mean of interpolated sensor signal as prediction (for demo)
sensor_pred = mean(sensor_signal_interp)*ones(size(sensor_signal_interp));

% Calculate residual
residual = abs(sensor_faulty - sensor_pred);

% Fault detection threshold (tuned empirically)
threshold = 0.003;

% Detect fault flags (1 if residual > threshold)
fault_flags = residual > threshold;

% --- Fault-tolerant switching ---
% Simple logic: if faulty, rely on backup signal (here original interpolated sensor_signal)
sensor_reliable = sensor_faulty; % Start with faulty signal
sensor_reliable(fault_flags) = sensor_signal_interp(fault_flags); % Replace faulty samples with original

% --- Plot all signals for visualization ---
figure;
plot(t, sensor_signal_interp, 'g-', 'LineWidth', 1.5); hold on;
plot(t, sensor_faulty, 'r--', 'LineWidth', 1.5);
plot(t, sensor_reliable, 'b-', 'LineWidth', 1.5);
legend('Original Sensor','Faulty Sensor','Fault-Tolerant Output');
xlabel('Time (s)');
ylabel('Sensor Signal');
title('Sensor Fault Injection and Fault-Tolerant Switching');
grid on;
