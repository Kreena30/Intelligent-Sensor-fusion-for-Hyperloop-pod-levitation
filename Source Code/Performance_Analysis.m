% Extract relevant signals and time
t = gapWS.time;
gap = gapWS.signals.values;       % Actual levitation gap
GapEst = GapEstWS.signals.values; % Estimated gap
forceCmd = forceWS.signals.values; % Control force command

% Interpolate GapEst to match the length of t
paramGapEst = linspace(0, 1, size(GapEst,1));
paramT = linspace(0, 1, length(t));

GapEstInterp(:,1) = interp1(paramGapEst, GapEst(:,1), paramT);
GapEstInterp(:,2) = interp1(paramGapEst, GapEst(:,2), paramT);

target_gap = 0.01; % Target gap in meters (adjust as per your model)

% Calculate Rise Time (time to reach 90% of target gap)
rise_idx = find(gap >= 0.9 * target_gap, 1);
if ~isempty(rise_idx)
    rise_time = t(rise_idx);
else
    rise_time = NaN;
end

% Calculate Overshoot (maximum peak minus target)
overshoot = max(gap) - target_gap;

% Calculate Settling Time (time to stay within +/-5% of target gap)
tolerance = 0.05 * target_gap;
settle_indices = find(abs(gap - target_gap) > tolerance);
if isempty(settle_indices)
    settling_time = 0; % Always within tolerance
else
    settling_time = t(settle_indices(end)); % Last time outside tolerance
end

% Calculate Steady-State Error (difference at end of simulation)
steady_state_error = gap(end) - target_gap;

% Display results
fprintf('Performance Metrics:\n');
fprintf('Rise Time: %.3f seconds\n', rise_time);
fprintf('Overshoot: %.5f meters\n', overshoot);
fprintf('Settling Time: %.3f seconds\n', settling_time);
fprintf('Steady-State Error: %.5f meters\n\n', steady_state_error);

% Optional: Plot actual vs estimated gap for visual comparison
figure;
plot(t, gap, 'b-', 'LineWidth', 1.5);
hold on;
plot(t, GapEstInterp(:,1), 'r-', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Gap (m)');
title('Actual vs Estimated Gap');
legend('Actual Gap','Estimated Gap');
grid on;
