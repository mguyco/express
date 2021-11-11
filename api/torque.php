<?php
$DB = new mysqli('localhost', 'id17474761_torque', 'r4*-GLR--#O<[g|b');

$DB->select_db('id17474761_mguy');

$DB->query("INSERT INTO torque_log (headers,data) VALUES ('" . addslashes(json_encode(getallheaders())) . "','" . addslashes(json_encode($_GET)) . "')");

print('OK!');

exit;
?>