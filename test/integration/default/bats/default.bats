@test "correct attribute values processed by template" {
	grep -F 'foo1a = bar1' /var/tmp/node-data.txt
	grep -F 'foo1b = baz' /var/tmp/node-data.txt
	grep -F 'foo2 = bar2' /var/tmp/node-data.txt
	grep -F 'foo3 = bar3' /var/tmp/node-data.txt
	grep -F 'foo4 = bar4' /var/tmp/node-data.txt
}
