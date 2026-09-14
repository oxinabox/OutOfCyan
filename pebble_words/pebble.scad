p_dim=50;
seed = 5;

function two_d_normal(mseed) =
    let (
        u = rands(0, 1, 2, mseed),
        r = sqrt(-1 * ln(u[0])),
        theta = 360 * u[1]
    )
    [r*sin(theta), r*cos(theta)];

function hadamard(a,b) = !is_list(a) ? a*b : [ for(i = [0:len(a)-1]) hadamard(a[i],b[i]) ]; 


for (ii = [1:50]){
    s = 5*hadamard([5,5,1.4], rands(0.2, 1, 3, 1000*seed*ii));
    pos = p_dim * hadamard([1,2],rands(0,1, 2, seed*ii));
    translate([pos[0], pos[1], s[2]])
        scale(s)
                sphere(1);
}

%hull() {
    for (ii = [1:50]){
        s = 5*hadamard([5,5,1.4], rands(0.2, 1, 3, 1000*seed*ii));
        pos = p_dim * hadamard([1,2],rands(0,1, 2, seed*ii));
        translate([pos[0], pos[1], s[2]])
            scale(s)
                 sphere(1);
    }
};