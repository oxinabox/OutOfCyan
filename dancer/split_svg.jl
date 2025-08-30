using XML

input_filename = joinpath(@__DIR__, "input", "dancer.svg")

image_name = splitext(basename(input_filename))[1]

doc = read(input_filename, Node)

root = doc[end]


colored_paths = Vector{Pair{String, Vector{Node}}}()
previous_color = ""
for child in children(root)
    color = lstrip(child["fill"], '#')
    if color != previous_color
        push!(colored_paths, color => Vector{Node}())
    end

    push!(colored_paths[end][2], child)
    previous_color = color
end

output_dir = mkpath(joinpath(@__DIR__, "output", image_name))
open(joinpath(output_dir, "image.scad"), "w") do scad_fh
    for (ii, (color, paths)) in enumerate(colored_paths)
        svg_filename = joinpath(output_dir, "$ii-$color.svg")
        XML.write(
            svg_filename,
            XML.Document(XML.Element(tag(root),
                paths...; (Symbol(k)=>v for (k, v) in attributes(root))...
            ))
        )
        println(
            scad_fh,
            """color("#$color") translate([0, 0, $(0.1*ii)]) import("$svg_filename", center=false);"""
        )
    end
end