module prism(l, w, h){
  union(){
  polyhedron(
    points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
    faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
  );
  mirror([0,0,1])
  polyhedron(
    points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
    faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
  );
  }
}

interection(){
    prism(5, 5, 3);
    
    color("red")
    rotate([0,90,0])
    translate([-2.5, 5,2.5])
    prism(5, -5, 3);
};
