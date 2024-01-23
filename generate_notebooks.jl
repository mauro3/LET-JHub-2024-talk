using GlacioTeaching

# this file-types are just copied over
asset_files = [".csv"]

for typ in [:assignment, :sol]
    outdir = if typ==:assignment
        joinpath(@__DIR__, "notebook")
    else
        joinpath(@__DIR__, "notebook-solution")
    end
    GlacioTeaching.process_folder("scripts", outdir, :nb;
        make_outputs=typ,
        execute=false, #:sol,
        path_nbinclude=nothing,
        asset_files
    )
end
