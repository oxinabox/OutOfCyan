using Pkg: @pkg_str
pkg"activate --temp"
pkg"add GLMakie GeometryBasics LinearAlgebra"


using GLMakie
using GeometryBasics, LinearAlgebra

function frustum_snapshot(cam)
    r = Rect3f(-1, -1, -1, 2, 2, 2)
    rect_ps = Makie.convert_arguments(Lines, r)[1]
    inv_pv = inv(cam.projectionview[])
    return map(rect_ps) do p
        p = inv_pv * to_ndim(Point4f, p, 1)
        return p[Vec(1,2,3)] / p[4]
    end
end


ex = Point3f(1,0,0)
ey = Point3f(0,1,0)
ez = Point3f(0,0,1)

fig = Figure()

# Set up Scene shown by a camera
scene = LScene(fig[1, 1])
cc = Makie.Camera3D(scene.scene, projectiontype = Makie.Perspective, center = false)

linesegments!(scene, Rect3f(Point3f(-1), Vec3f(2)), color = :black)
linesegments!(scene,
    [-ex, ex, -ey, ey, -ez, ez],
    color = [:red, :red, :green, :green, :blue, :blue]
)
center!(scene.scene)

cam = scene.scene.camera
eyeposition = cc.eyeposition
lookat = cc.lookat
frustum = map(pv -> frustum_snapshot(cam), cam.projectionview)

# Set up scene visualizing the cameras view
scene = LScene(fig[1, 2])
_cc = Makie.Camera3D(scene.scene, projectiontype = Makie.Orthographic, center = false)
lines!(scene, frustum, color = :blue, linestyle = :dot)
scatter!(scene, eyeposition, color = :black)
scatter!(scene, lookat, color = :black)

linesegments!(scene,
    [-ex, ex, -ey, ey, -ez, ez],
    color = [:red, :red, :green, :green, :blue, :blue]
)
linesegments!(scene, Rect3f(Point3f(-1), Vec3f(2)), color = :black)

# Tweak initial camera position
update_cam!(scene.scene, Vec3f(4.5, 2.5, 3.5), Vec3f(0))
update_cam!(scene.scene, Vec3f(6, 8, 5), Vec3f(0))

display(fig)
sleep(10)
