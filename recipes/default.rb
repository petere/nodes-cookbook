nodes_bag = begin
              data_bag('nodes')
            rescue Chef::Exceptions::InvalidDataBagPath, Net::HTTPServerException
              []
            end

if nodes_bag.include?(node.name)
  dbi = data_bag_item('nodes', node.name)

  %w(default force_default override force_override).each do |attr_type|
    attrs = dbi["#{attr_type}_attributes"] || {}
    attrs.each do |key, value|
      case attr_type
      when 'default'
        node.default[key] = value
      when 'force_default'
        node.force_default[key] = value
      when 'override'
        node.override[key] = value
      when 'force_override'
        node.force_override[key] = value
      end
    end
  end
end
