function tmf = beta_function(beta, N, r)
    delta(r) = (1-beta)*(r-1)/(N-1);
    tmf = [delta(r),beta/2+delta(r),beta+delta(r)];
end