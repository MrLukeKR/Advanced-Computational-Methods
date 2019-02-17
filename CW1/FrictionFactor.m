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

Re = varargin{1};

if nargin == 3
    roughness = varargin{2} / varargin{3};
else
    roughness = varargin{2};
end

lhs = @(x) 1./(sqrt(x));
rhs = @(x) -2.0 .* log((roughness ./ 3.7) + (2.51 ./ (Re .* (sqrt(x)))));

friction = @(f) lhs(f) - rhs(f) ;

f = fzero(friction, 1E-2);

end

