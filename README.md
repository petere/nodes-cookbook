# nodes cookbook

This is a cookbook for managing node attributes in data bags.

The idea is, you probably keep your cookbooks, roles, environments,
and data bags under version control, and maybe you even upload them
via a CI server.  Great.  But then you can also set attributes on
individual nodes using `knife node edit`.  That doesn't sound like a
good idea for long-term maintainability.  Some people create per-node
roles, but that doesn't seem very attractive.

So the solution proposed here is to store per-node attributes in data
bag items.  To make node-specific attribute changes, you just
manipulate and upload your data bags using your normal change process.
And include this cookbook in your run list to make the changes
effective.

More precisely, at this to your run list, ideally very early:

    recipe[nodes]

Structure your data bags this way:

    data_bags/
    +---nodes/
        +---host1.example.com.json
        +---host2.example.com.json

The data bag item name should be the Chef node name (usually the host
name, but not necessarily).

The individual per-node data bag items should look like this:

```json
{
  "id": "host1.example.com",

  "default_attributes": {
    "foo1": "bar1"
  },
  "force_default_attributes": {
    "foo2": "bar2"
  },
  "override_attributes": {
    "foo3": "bar3"
  },
  "force_override_attributes": {
    "foo4": "bar4"
  }
}
```

This looks very similar to a role or environment JSON file.

The attributes are actually applied in a recipe, so they have lower
precedence than roles or environments.  Since a per-node setting is
usually supposed to override such global settings, the `force_`
variants will often be useful.

Here is a somewhat realistic example:

```json
{
  "id": "specialhost.example.com",

  "force_override_attributes": {
    "sysctl": {
      "params": {
        "vm": {
          "swappiness": 0
        }
      }
    }
  }
}
```
