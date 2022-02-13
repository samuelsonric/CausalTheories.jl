# CausalTheories

Convert DAGs to wiring diagrams. See [here](https://arxiv.org/abs/1301.6201).

```julia
using CausalTheories
using Catlab, Catlab.CategoricalAlgebra, Catlab.Graphs, Catlab.Graphics, Catlab.Graphics.Graphviz, Catlab.WiringDiagrams

g = @acset Graphs.Graph begin
	V = 5
	E = 5
	src = [1, 2, 2, 3, 4]
	tgt = [5, 4, 3, 4, 5]
end
```

![network]("./img/network.svg")
```julia
to_graphviz(g; node_labels=true)
```

![diagram]("./img/diagram.svg")
```julia
to_graphviz(causalconditional(g))
```

