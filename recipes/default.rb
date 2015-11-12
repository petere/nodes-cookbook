require 'chef/mixin/deep_merge'

nodes_bag = begin
              data_bag('nodes')
            rescue Chef::Exceptions::InvalidDataBagPath, Net::HTTPServerException
              []
            end

if nodes_bag.include?(node.name)
  dbi = data_bag_item('nodes', node.name)

  %w(default force_default override force_override).each do |attr_type|
    attrs = dbi["#{attr_type}_attributes"] || {}
    case attr_type
    when 'default'
      node.default = Chef::Mixin::DeepMerge.merge(node.default, attrs)
    when 'force_default'
      node.force_default = Chef::Mixin::DeepMerge.merge(node.force_default, attrs)
    when 'override'
      node.override = Chef::Mixin::DeepMerge.merge(node.override, attrs)
    when 'force_override'
      node.force_override = Chef::Mixin::DeepMerge.merge(node.force_override, attrs)
    end
  end
end
