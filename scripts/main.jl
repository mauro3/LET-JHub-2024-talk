#src # This is needed to make this run as normal Julia file:
using Markdown #src

#src # This is needed for the Jupyter-RISE plugin to run as a slide-show:
#nb # %% A slide [markdown] {"slideshow": {"slide_type": "slide"}}
md"""
# Juptyer notebooks, slides and website all at once

_LET JHub user meeting 01-2024_ ; _Mauro Werder_

I will go over
- how to generate Jupyter notebooks from scripts for:
  - notebooks
  - assignments and solutions
  - web-pages
- to show you how we use (interactive) computing exercises in our lectures.

This is in Julia but a similar setup should work for Python, R, ...
"""

#nb # %% A slide [markdown] {"slideshow": {"slide_type": "slide"}}
md"""
# Why not just straight notebooks?

- notebooks are great for teaching but a bit less great for maintaining
- clunky git integration
- awkward editing
- hard to keep lectures, assignments and solutions in sync

--> use one script to rule them all: i.e. generate all notebooks and other
    outputs from one, text-based script
"""

#nb # %% A slide [markdown] {"slideshow": {"slide_type": "slide"}}
md"""
# Example: a quick intro to programming in Julia
"""

#nb # %% A slide [markdown] {"slideshow": {"slide_type": "fragment"}}
md"""
### Basic Julia datatypes
- numbers (Ints, Floats, Complex, etc.)
- arrays
- ...
"""

1     # 64 bit integer (or 32 bit if on a 32-bit OS)
1.5   # Float64
#-
typeof(1.5)
#-
[1, 2, 3,] # array of eltype Int


#src #########################################################################
#nb # %% A slide [markdown] {"slideshow": {"slide_type": "slide"}}
md"""
# Example: a quick intro to programming in Julia
### Array exercises
"""

# Task: assign two vectors to `a`, and `b` and the concatenate them using `;`:

a = [2, 3]
#hint b = ...
#hint [ ; ]
b = [4, 5] #sol
[a ; b] #sol

# Add new elements to the end of Vector `b` (hint look up the documentation for `push!`)

#hint ##
push!(b, 1) #sol
push!(b, 3, 4) #sol



#nb # %% A slide [markdown] {"slideshow": {"slide_type": "slide"}}
md"""
# What does the script look like?
"""

#nb # %% A slide [markdown] {"slideshow": {"slide_type": "fragment"}}
md"""
See [main.jl](https://github.com/mauro3/LET-JHub-2024-talk/blob/master/scripts/main.jl) on Github:
`````julia
# Example: a quick intro to programming in Julia
### Array exercises

# Task: assign two vectors to `a`, and `b` and the concatenate them using `;`:

a = [2, 3]
##hint b = ...
##hint [ ; ]
b = [4, 5] ##sol
[a ; b] ##sol

# Add new elements to the end of Vector `b` (hint look up the documentation for `push!`)

##hint ##
push!(b, 1) ##sol
push!(b, 3, 4) ##sol
`````
"""

#nb # %% A slide [markdown] {"slideshow": {"slide_type": "slide"}}
md"""
# Tech stack

- Julia
- Jupyter
- Slide show: [Rise](https://github.com/damianavila/RISE) plugin for Jupyter
- [Literate.jl](https://github.com/fredrikekre/Literate.jl)

Output of Literate.jl: pure Julia, markdown, Jupyter notebooks
"""

#nb # %% A slide [markdown] {"slideshow": {"slide_type": "fragment"}}
md"""
--> should be possible in other programming languages too
"""

#nb # %% A slide [markdown] {"slideshow": {"slide_type": "slide"}}
md"""
# How we use it

- in-class notebooks
- slides for teaching
- assignments and their solutions
- website of course [Solving PDEs on GPUs](https://pde-on-gpu.vaw.ethz.ch/)
"""

#nb # %% A slide [markdown] {"slideshow": {"slide_type": "fragment"}}
md"""
# Concluding

- all the content (slides, exercise, exercise solution) you saw today is generated from one script
  - on [https://github.com/mauro3/LET-JHub-2024-talk](https://github.com/mauro3/LET-JHub-2024-talk)
  - this keeps things simple when doing and updating exercises
  - simple system of hash-tags within script to generate different content
  - how the PDE-on-GPU lecture operates, also its website generated like this
  - how parts of Physics of Glaciers lecture operates
- should be possible with other programming languages and a literate-type programming package
"""
