module AASMDiagram
  #
  # Save a diagram of a single AASM state machine to an image
  #
  class Diagram
    def initialize(aasm_instance, filename)
      @aasm_instance = aasm_instance
      draw
      save(filename)
    end

    def draw
      @graphviz = GraphViz.new(:G, type: :digraph)
      draw_nodes
      draw_edges
    end

    def draw_nodes
      state_names.map do |state_name|
        @graphviz.add_nodes(state_name.to_s)
      end
    end

    def draw_edges
      events.each do |event|
        event.transitions.each do |transition|
          from = @graphviz.get_node(transition.from.to_s)
          to = @graphviz.get_node(transition.to.to_s)
          label = event.name.to_s
          @graphviz.add_edges(from, to, label: label)
        end
      end
    end

    def save(filename)
      @graphviz.output(png: filename)
    end

    private

    def states
      @aasm_instance.states
    end

    def state_names
      states.map(&:name)
    end

    def events
      @aasm_instance.events.first.state_machine.events.values
    end
  end
end
