function brownian2(N,p)
% BROWNIAN2  2-D Brownian motion.
%   BROWNIAN(N,p) takes N random steps with p point particles.
clf % clears current figure
shg % brings figure to front
set(gcf,'doublebuffer','on') % smooths plotting of points
% Set defaults
if nargin < 1, N = 1000; end
if nargin < 2, p = 100; end
% Initialize arrays
x = zeros(p,1);
y = zeros(p,1);
z = zeros(p,1);

r = zeros(N,1);
R = zeros(N,1);
% Initialize plot
h = scatter3(x,y,z,'.');
axis([-1 1 -1 1 -1 1])
axis square
delta = .002;
% For loop to generate moves
for n = 1:N
   x = x + delta*randn(p,1);
   y = y + delta*randn(p,1);
   z = z + delta*randn(p,1);
   set(h,'xdata',x,'ydata',y,'zdata',z) % sets new positions on plot
   xl = "steps=" + string(n); % displays number of steps on plot
   xlabel(xl)
   drawnow nocallbacks
   % Gathers position information for later plotting
   r(n,1) = mean(sqrt(x.^2 + y.^2 + z.^2));
   R(n,1) = max(sqrt(x.^2 + y.^2 + z.^2));
end
pause % Stops program until user keystroke
clf
% Quick and dirty line fit
n = (1:N)';
c = sqrt(n)\r;
C = sqrt(n)\R;
plot(n,[c*sqrt(n) C*sqrt(n) r R])
legend('Average Fit', 'Max Fit', 'Average Behavior','Max Behavior','Location','northwest' )
xlabel('steps')
ylabel('Distance')