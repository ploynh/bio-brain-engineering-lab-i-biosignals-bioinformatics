% model the given network dynamics
function dydt = michaelis_menten_model(t, y, I0, Y0)
    dydt = ((1-y)*I0)/(2-y) - (y*Y0)/(1+y);
end
