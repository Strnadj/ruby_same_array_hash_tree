class SameHashArrayTree
  # Simple tree node
  class TreeNode
    attr_accessor :name, :parent, :descendants, :data
    def initialize(name, parent)
      @name        = name
      @parent      = parent
      @descendants = []
      @data        = []
    end

    def get_descendant(name)
      @descendants.find { |m| m.name == name } || create_descendant(name)
    end

    # Get chain
    # @params with_root Boolean, root is always last
    # @return Array
    def get_chain(with_root = false)
      # Prepare temporary variables
      tmp = self
      ret = []
      while tmp
        ret << tmp.name
        tmp = tmp.parent
      end

      # Remove root (last item)
      ret.pop unless with_root

      # Return
      ret
    end

    private

    def create_descendant(name)
      descendant = TreeNode.new(name, self)
      @descendants << descendant
      descendant
    end
  end

  # Root node, data position
  attr_accessor :root, :occupied_descendants

  def initialize(struct, root_name = :root)
    # Create struct from nodes
    @root = TreeNode.new(root_name, nil)
    @occupied_descendants = []

    # Go to struct and create data structures
    struct.each do |data_id, chain|
      add_node(data_id, chain)
    end
  end

  # Return is an array of arrays
  # [[data_id,chain],[data_ids,chain]]
  def get_results(with_root = false)
    ret = []

    # Iterate over all occupied descendants and create chain data
    @occupied_descendants.each do |node|
      ret << [node.data, node.get_chain(with_root)]
    end

    # Return
    ret
  end

  def add_node(data_id, chain)
    # Sort chain (it's symbols)
    chain = chain.sort.uniq

    # Prepare variable for end-of-chain
    descendant = @root

    # Start from beggining
    chain.each do |item|
      descendant = descendant.get_descendant(item)
    end

    # Add data_id to descendant
    descendant.data << data_id

    # Mark as occupied node
    unless @occupied_descendants.include?(descendant)
      @occupied_descendants << descendant
    end

    # Return node
    descendant
  end
end
