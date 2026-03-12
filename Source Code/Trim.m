t_trimmed = t(1:length(GapEst)); % Use first 20001 points of t
plot(t_trimmed, GapEst(:,1), 'r-', 'LineWidth', 1.5);
% If you want to plot both columns:
hold on;
plot(t_trimmed, GapEst(:,2), 'b--', 'LineWidth', 1.5);
hold off;
