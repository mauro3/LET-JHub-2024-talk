#src # This is needed to make this run as normal Julia file:
using Markdown #src

#src # This is needed for the Jupyter-RISE plugin to run as a slide-show:
#nb # %% A slide [markdown] {"slideshow": {"slide_type": "slide"}}
#nb # Calving and teaching ; _Fachgespräch 2023_ ; _Mauro Werder_
md"""
# Juptyer notebooks, slides and website all at once

I will go over
- how to generate Jupyter notebooks from scripts (i.e. text-only) for:
  - notebooks
  - assignments and solutions
  - web-pages
- to show you how we use (interactive) computing exercises in our lectures.
"""

#nb # %% A slide [markdown] {"slideshow": {"slide_type": "slide"}}
md"""
# Class exercise: Implement calving by flotation

- head to Moodle: https://moodle-app2.let.ethz.ch and login with ETHZ credentials
- Open "Demokurs Mauro Werder" and you'll find:
  - a JupyterHub link
  - an assignment "Calving" -> click on this
    - click on "Get a copy of the assignment"
    - put it into the folder "assignments/" (or anywhere, really)
  - go back and open the JupyterHub
"""

#nb # %% A slide [markdown] {"slideshow": {"slide_type": "slide"}}
md"""
# Input data

Read input data (all on flow-lines) as well as some additional data.

Data covers the years 2023 to 2060 and was simulated with GERMS by Jane (tnx!)
"""
using DelimitedFiles
x = readdlm("coord.csv", ',')/1e3 # divide to have kilometers
surfs = readdlm("means-45.csv", ',')
bed = readdlm("bed.csv", ',')[:] # sorry, the [:] is to make a vector from the matrix
thicks = surfs .- bed
## set any thickness below 1m to zero:
thicks[thicks.<1] .= 0
dyear = 2022 # can be used to calculated index from year
level_nat_lake = 2198
level_dam_lake = 2250

#nb # %% A slide [markdown] {"slideshow": {"slide_type": "slide"}}
md"""
# Plot (some of) the input data
"""
## load plotting package
using PyPlot

## plot it
plot(x, bed, label="bed")
plot(x, level_nat_lake .+ bed*0, label="nat. lake", color="blue", linestyle=":")
plot(x, level_dam_lake .+ bed*0, label="dammed lake", color="blue", linestyle="--")
for y in [2023, 2035, 2045]
    plot(x, surfs[:,y - dyear], label=y)
end
legend()

#nb # %% A slide [markdown] {"slideshow": {"slide_type": "slide"}}
md"""
# Class exercise: Step 0

Execute all of above code-cells before starting by moving the cursor into
it and hitting "Shift + enter"
"""

#nb # %% A slide [markdown] {"slideshow": {"slide_type": "slide"}}
md"""
# Class exercise: Step 1 -- water equivalent line

Plot the water equivalent line for the year 2023 together with bed and ice surface elevation.

The water equivalent line is bed-elevation plus water equivalent thickness of the ice.

Fill in the dots below:
"""
rho_i, rho_w = 910, 1000

y = 2023
equiv = bed .+ thicks[:, y - dyear]* rho_i/rho_w #sol
#hint equiv = bed .+ thicks[ ...] * ...
plot(x, bed, label="bed")
plot(x, equiv, label="water equivalent")
plot(x, surfs[:, y - dyear], label="ice surface $y")
legend()

#nb # %% A slide [markdown] {"slideshow": {"slide_type": "slide"}}
md"""
# Class exercise: Step 2 -- flotation criterion calving

Create a function `calve` which chops off any ice above flotation threshold.  I.e. any ice
where the water equivalent line is lower than the lake-level.
"""

"""
    calve(surf, bed, lake_level)

Returns glacier surface after calving according to the flotation criterion.

Input:
- `surf` and `bed` vectors of surface and bed elevation
- `lake_level` elevation of lake surface
"""
function calve(surf, bed, lake_level)
    ## calculate the ice thickness (use .- for element-wise subtraction):
    #hint thick = ...
    thick = surf .- bed #sol
    #hint equiv = ... # adapt from Step 1
    equiv = bed .+ thick * rho_i/rho_w #sol
    ## set all calved-off points to bed elevation
    surf[equiv.<lake_level] .= bed[equiv.<lake_level]
    return surf
end

#nb # %% A slide [markdown] {"slideshow": {"slide_type": "slide"}}
md"""
# Class exercise: Step 3

Plot the original and calved off geometry for the dammed lake in years
2023, 2035 and 2045.
"""
## plot
plot(x, bed, label="bed")
plot(x, level_dam_lake .+ bed*0, label="dammed lake", color="blue", linestyle="--")
for y in [2023, 2035, 2045]
    plot(x, calve(surfs[:, y - dyear], bed, level_dam_lake), label="$y with lake") #sol
    #hint plot(x, calve(...), label="$y with lake")
    plot(x, surfs[:, y - dyear], label=label="$y no lake")
end
legend()

#nb # %% A slide [markdown] {"slideshow": {"slide_type": "slide"}}
md"""
# Class exercise: submit

Please submit this notebook via Moodle:
- head to the "Calving" assignments on the Moodle course
- click "Add submission"
- under "Folder to submit" choose the "notebook" folder
- submit
"""



#nb # %% A slide [markdown] {"slideshow": {"slide_type": "slide"}}
md"""
# Teaching conclusions

- all the content (slides, exercise, exercise solution) you saw today is generated from the two script
  - this keeps things simple when doing and updating exercises
  - simple system of tags to generate different content
  - how the PDE-on-GPU lecture operates, also its website generated like this
  - how parts of Physics of Glaciers lecture operates
- should be possible with other programming languages and a literate-type programming package
- integration with Moodle pretty good
"""
