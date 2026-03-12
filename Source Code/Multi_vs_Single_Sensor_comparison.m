t = gapWS.time;                        % Time vector
gap = gapWS.signals.values;            % Actual levitation gap (ground truth)
GapEst_fusion = GapEstWS.signals.values(:,1);   % Fusion estimate (e.g., from EKF)
GapEst_single = GapEstWS.signals.values(:,2);   % Single sensor estimate (example: second sensor)

% Interpolate all to the same length as time vector t
paramGapEstFusion = linspace(0, 1, length(GapEst_fusion));
paramGapEstSingle = linspace(0, 1, length(GapEst_single));
paramGap = linspace(0, 1, length(gap));
paramT = linspace(0, 1, length(t));

GapEst_fusion_interp = interp1(paramGapEstFusion, GapEst_fusion, paramT);
GapEst_single_interp = interp1(paramGapEstSingle, GapEst_single, paramT);
gap_interp = interp1(paramGap, gap, paramT);

% Calculate errors
error_fusion = GapEst_fusion_interp - gap_interp;
error_single = GapEst_single_interp - gap_interp;

% Calculate metrics
mse_fusion = mean(error_fusion.^2);
mse_single = mean(error_single.^2);

std_fusion = std(error_fusion);
std_single = std(error_single);

max_err_fusion = max(abs(error_fusion));
max_err_single = max(abs(error_single));

% Display metrics
fprintf('Comparison Metrics:\n');
fprintf('Mean Squared Error (Fusion): %.6f, (Single): %.6f\n', mse_fusion, mse_single);
fprintf('Standard Deviation Error (Fusion): %.6f, (Single): %.6f\n', std_fusion, std_single);
fprintf('Maximum Absolute Error (Fusion): %.6f, (Single): %.6f\n', max_err_fusion, max_err_single);

% Plot Actual vs Estimates
figure;
plot(t, gap_interp, 'k-', 'LineWidth', 1.5); hold on;
plot(t, GapEst_fusion_interp, 'b--', 'LineWidth', 1.5);
plot(t, GapEst_single_interp, 'r:', 'LineWidth', 1.5);
legend('Actual Gap', 'Fusion Estimate', 'Single Sensor Estimate');
xlabel('Time (s)');
ylabel('Gap (m)');
title('Gap Estimation: Fusion vs Single Sensor');
grid on;

% Plot Absolute Errors
figure;
plot(t, abs(error_fusion), 'b-', 'LineWidth', 1.5); hold on;
plot(t, abs(error_single), 'r-', 'LineWidth', 1.5);
legend('Fusion Error', 'Single Sensor Error');
xlabel('Time (s)');
ylabel('Absolute Error (m)');
title('Estimation Error Magnitudes');
grid on;
