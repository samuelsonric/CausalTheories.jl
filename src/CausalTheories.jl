module CausalTheories

using Catlab, Catlab.Theories, Catlab.CategoricalAlgebra, Catlab.Programs, Catlab.Graphics, Catlab.Graphics.Graphviz, Catlab.Graphs, Catlab.WiringDiagrams

import Catlab.WiringDiagrams: WiringDiagram

export causalconditional

@present C(FreeSchema) begin
	InPort::Ob
	Wire::Ob
	OutPort::Ob
	OutWire::Ob
	OuterOutPort::Ob
	Box::Ob

	BoxValue::AttrType

	tgt::Hom(Wire, InPort)
	src::Hom(Wire, OutPort)
	out_src::Hom(OutWire, OutPort)
	out_tgt::Hom(OutWire, OuterOutPort)

	in_port_box::Hom(InPort, Box)
	out_port_box::Hom(OutPort, Box)

	in_port_type::Attr(InPort, BoxValue)
	out_port_type::Attr(OutPort, BoxValue)
	outer_out_port_type::Attr(OuterOutPort, BoxValue)
	value::Attr(Box, BoxValue)
end

@acset_type CSet(C)

function WiringDiagram(x::CSet{BoxValue}) where BoxValue
	wd = WiringDiagram{Any, BoxValue, Nothing, BoxValue}([], [])
	copy_parts!(wd.diagram, x)
	set_subpart!(wd.diagram, :box_type, Box{BoxValue})
	wd
end

F = @finfunctor C BasicGraphs.TheoryGraph begin
	Wire => E
	InPort => E
	OutPort => V
	OutWire => V
	OuterOutPort => V
	Box => V

	BoxValue => V

	tgt => id(E)
	src => src
	out_src => id(V)
	out_tgt => id(V)

	in_port_box => tgt
	out_port_box => id(V)

	in_port_type => src
	out_port_type => id(V)
	outer_out_port_type => id(V)
	value => id(V)
end

ΔF = DeltaMigration(F, Graphs.Graph, CSet{Int})

causalconditional(g::Graphs.Graph) = add_junctions(WiringDiagram(ΔF(g)))

end
