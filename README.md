Ruby Same Hash-Array Tree
=========================

Structure for merge the same data arrays by tree.

You have data like this:

## Input

    hash = {
      a: %w(a b c d),
      b: %w(c f g),
      c: %w(a b c g),
      d: %w(c b d a),
      e: %w(a c b d),
      f: %w(g f c)
    }
    
And you're looking for the same keys with same values, there are two possible ways how to do that (maybe more, but I stuck on those two). First is compare all arrays to each other, which may have a performance issues. Or you can create tree with it and save active nodes. With tree you can avoid performance issues for the price of memory size.
    
## Output

    [
      [ [ :a, :c, :d ], [ d, c, b, a ] ],
      [ [ :b, :f ], [ c, f, g ] ],
      [ [ :c ], [ a, b, c, g ] ]
    ]
    
It's really easy library which I hope it can be useful for somebody in the feature.

# Usage

    u = SameHashArrayTree.new({ a: %w(a b c d)})
    u.add_node :b, %w(c f g)
    u.add_node :c, %w(a b c g)
    u.add_node :d, %w(c b d a)
    u.add_node :e, %w(a c b d)
    u.add_node :f, %w(g f c)
    u.get_results
    #  [[[:a, :d, :e], ["d", "c", "b", "a"]], [[:b, :f], ["g", "f", "c"]], [[:c], ["g", "c", "b", "a"]]]
    
