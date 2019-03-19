function [T] = anharmonicosc(a, varargin)

switch nargin
    case 0
        error("")
    case 1
        %use harmonic potential
        V = @(x) x^2;
    case 2
        V = @(x) varargin(1);
end
m = 1;

%function for v?
V = @(x) x^2;
%V = @(x) E-0.5*m*v^2;

int = @(x) 1/(V(a)-V(x))^(1/2);

T = 4*integral(int, 0, a);



end