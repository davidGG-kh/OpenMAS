function res = ne(A,B)
%NE           Implements  A~=B  elementwise for long (refers only to midpoints)
%

% written  11/06/99     S.M. Rump
% modified 04/04/04     S.M. Rump  set round to nearest for safety
% modified 04/06/05     S.M. Rump  rounding unchanged
%

  C = A - B;
  res = any( C.mantissa~=0 , 2);
