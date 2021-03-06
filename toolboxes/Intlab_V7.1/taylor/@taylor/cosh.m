function r = cosh(a)
%COSH         Taylor hyperbolic cosine  cosh(a)
%

% written  05/21/09     S.M. Rump
% modified 08/26/12     S.M. Rump  global variables removed
%

  e = 1e-30;
  if 1+e==1-e                   % fast check for rounding to nearest
    rndold = 0;
  else
    rndold = getround;
    setround(0)
  end

  K = getappdata(0,'INTLAB_TAYLOR_ORDER');

  st = a.t;
  r = a;
  N = size(a.t,2);
  st(1,:) = sinh(a.t(1,:));
  r.t(1,:) = cosh(a.t(1,:));
  for j=2:K
    at_ = a.t(2:j,:);           % some 3 % faster 
    st(j,:) = sum( repmat((1:j-1)',1,N).*r.t(j-1:-1:1,:).*at_ , 1 ) ./ (j-1);
    r.t(j,:) = sum( repmat((1:j-1)',1,N).*st(j-1:-1:1,:).*at_ , 1 ) ./ (j-1);
  end
  r.t(K+1,:) = sum( repmat((1:K)',1,N).*st(K:-1:1,:).*a.t(2:K+1,:) , 1 ) ./ K;

  if rndold
    setround(rndold)
  end
