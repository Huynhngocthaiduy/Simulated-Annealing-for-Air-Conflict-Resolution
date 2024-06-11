figure(1);
plot(Graph(:,2));
hold on;
plot(Graph(:,3)/10);
title('Number of conflict and the total cost in Descent method (First acceptance Condition)');
xlabel('Time') % x-axis label
ylabel('Number of Conflict (blue)-Total Cost (orange)') % y-axis label

figure(2);
plot(Graph(:,4));
hold on;
plot(Graph(:,5)/15);
title('Number of conflict and the total cost in Descent method');
xlabel('Time') % x-axis label
ylabel('Number of Conflict (blue)-Total Cost (orange)') % y-axis label