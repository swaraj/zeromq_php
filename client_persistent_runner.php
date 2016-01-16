<?php
exec(sprintf("%s > %s 2>&1 &", 'php zeromq_persistent_client.php', 'pclient1.log', null));
exec(sprintf("%s > %s 2>&1 &", 'php zeromq_persistent_client.php', 'pclient2.log', null));
exec(sprintf("%s > %s 2>&1 &", 'php zeromq_persistent_client.php', 'pclient3.log', null));