% to build complete matrix rather than cells
function  [tt2] = buildmatrix(tt0,tt1,T,pT)

  tt2 = zeros(1,pT+1);
  tt2(pT-T+1:pT+1) = [tt0 tt1];

return;