@test "correct attribute values processed by template" {
	grep -F 'foo1a = ' /var/tmp/node-data.txt
	grep -F 'foo2 = bar2' /var/tmp/node-data.txt
	grep -F 'foo3 = ' /var/tmp/node-data.txt
	grep -F 'foo4 = ' /var/tmp/node-data.txt
}
