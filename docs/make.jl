using OutOfCyan
using Documenter

DocMeta.setdocmeta!(OutOfCyan, :DocTestSetup, :(using OutOfCyan); recursive = true)

const page_rename = Dict("developer.md" => "Developer docs") # Without the numbers
const numbered_pages = [
    file for file in readdir(joinpath(@__DIR__, "src")) if
    file != "index.md" && splitext(file)[2] == ".md"
]

makedocs(;
    modules = [OutOfCyan],
    authors = "Frames Catherine White",
    repo = "https://github.com/oxinabox/OutOfCyan.jl/blob/{commit}{path}#{line}",
    sitename = "OutOfCyan.jl",
    format = Documenter.HTML(; canonical = "https://oxinabox.github.io/OutOfCyan.jl"),
    pages = ["index.md"; numbered_pages],
)

deploydocs(; repo = "github.com/oxinabox/OutOfCyan.jl")
