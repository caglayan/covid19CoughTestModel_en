function r = entropy_renyi(n,alpha)

%ENTROPY_RENYI Renyi's entropy of a distribution
% function [r,rmax,rmin] = entropy_renyi(n,alpha)
% Given a frequency vector calculates its entropy by 1/(1-alpha)*log2(sum_i(pi^alpha))
% log2 is equivalent to ln (just scaling)
% n - vector with counts
% alpha>=0 - order, default=2
% r -  entropy (Renyi) - always  between rmin and rmax for given n
% rmax - maximum entropy for the same number of classes = log2(length(n)),
%   or alpha=0
% rmin - minimum entropy achieved for alpha->inf
% Susana Vinga (svinga@itqb.unl.pt) 16 August 2003
% See also: entropy.m (only Shannon's entropy <=> alpha=1); renyi.tex
% corrected, 2003-04-23, 2003-07-22, corrected comments 2004-01-29

if nargin<2
    alpha=2; 
end;

p = n(:)./sum(n(:)); %frequency to probability

% for i=1:length(p) %all the 0 entries change to 1 for calculate the log -> better algorithm? : p(p==0)=1
%    if p(i)==0 
%       p(i)=1;
%    end
% end
if alpha==1 %Shannon's entropy
    p(p==0)=1;
    r = -sum(p.*log2(p));
%     disp(['Renyi''s entropy for alpha=' num2str(alpha) ' or Shannon''s entropy = ' num2str(r)]);
else
    %p;
    r = 1/(1-alpha)*log2(sum(p.^alpha));
%     disp(['Renyi''s entropy for alpha=' num2str(alpha) ' is ' num2str(r) ]);
end
rmax = log2(length(n)); %achieved for the uniform distribution in that set or for alpha=0
rmin = -log2(max(p));   %achieved for alpha->inf