% model the given network dynamics
function dydt = mainlabmodel(t, y, kz6)
    dydt = zeros(3,1);
    dydt(1) = ((1-y(1))/(2-y(1)))-(y(1)/(1+y(1)));
    dydt(2) = ((1-y(2))*y(1)/(2-y(2)))-(y(2)/(1+y(2)));
    dydt(3) = ((1-y(3))*y(1)/(2-y(3)))-(y(3)*y(2)*kz6/(1+y(3)));
end