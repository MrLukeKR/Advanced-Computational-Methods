% AUTHOR: Luke Rose, BSc Computer Science with Artificial Intelligence
% COURSE: EngD (Doctor of Engineering), CCS & CFE CDT
% MODULE: Advanced Computational Methods (H84ACM)

function f = FrictionFactor(varargin)
%FRICTIONFUNCTION Summary of this function goes here
%   Detailed explanation goes here

% Colebrook equation:
% 1 / sqrt(f) = -2.0 * log(((epsilon/D) / 3.7) + (2.51 / Re * sqrt(f)))

% Rearranged:
% 0 = (1 / sqrt(f)) - (-2.0 * log(((epsilon/D) / 3.7) + (2.51 / Re * sqrt(f))))
% 0 = (1 / sqrt(f)) + 2.0 * log(((epsilon/D) / 3.7) + (2.51 / Re * sqrt(f)))

%   Get the first argument from the input array as the "Reynolds Number"
    Re = varargin{1};

%   Overloaded function signature (allows for pre-calculated roughness or
%   Epsilon and Diameter to be entered and then calculated within this
%   function)
    if nargin == 3
        roughness = varargin{2} / varargin{3};
    elseif nargin == 2
        roughness = varargin{2};
    end

    lhs = @(x) 1./(sqrt(x));
    rhs = @(x) -2.0 * log((roughness ./ 3.7) + (2.51 ./ (Re .* (sqrt(x)))));

%   Use bisectional method to solve function with a tolerance of 1E-5
    f = Bisectional(@(f)(abs(lhs(f)) - abs(rhs(f))), 0, 1, 1E-5);
    fprintf("BISECT answer: %f\r", f);
end