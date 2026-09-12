base_radius = 5;
p_dim=50;
seed = 4;

function two_d_normal(mseed) =
    let (
        u = rands(0, 1, 2, mseed),
        r = sqrt(-1 * ln(u[0])),
        theta = 360 * u[1]
    )
    [r*sin(theta), r*cos(theta)];

function hadamard(a,b) = !is_list(a) ? a*b : [ for(i = [0:len(a)-1]) hadamard(a[i],b[i]) ]; 



    for (ii = [1:20]){
        p = p_dim * concat(hadamard([1,2],rands(0,1, 2, seed*ii)), [0]);
        s = hadamard([2,2,1.4], rands(0.2, 1, 3, 1000*seed*ii));
        translate(p)
            scale(s)
                 sphere(base_radius);
    }

%hull() {
    for (ii = [1:20]){
        p = p_dim * concat(hadamard([1,2],rands(0,1, 2, seed*ii)), [0]);
        s = hadamard([2,2,1.4], rands(0.2, 1, 3, 1000*seed*ii));
        translate(p)
            scale(s)
                 sphere(base_radius);
    }
};