push!(LOAD_PATH, pwd())
using .JuliaCUTEstModule

a=JuliaCUTEstModule.CUTEstModel("OSCIGRAD")
b=JuliaCUTEstModule.obj(a,ones(100000))