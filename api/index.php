<?php
ini_set('display_errors', true);
ini_set('display_startup_errors', true);
ini_set('memory_limit', '-1');
ini_set('SMTP', '204.11.148.20');
date_default_timezone_set('UTC');
error_reporting(E_ALL);

header('Content-type: application/json');
header('Cache-Control: no-cache');
header('Connection: keep-alive');
header('Access-Control-Allow-Origin: *');
//header('Access-Control-Allow-Methods: GET, PATCH, PUT, POST, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Origin, Content-Type');
header('Access-Control-Max-Age: 86400');

$_RESPONSE = false;
$_JSON = false;
$_ENDPOINT = false;
$_DATA = false;
$_SQL = false;

if(!empty($_GET['endpoint'])) $_ENDPOINT = urldecode(trim($_GET['endpoint']));

if(!$_ENDPOINT) die('{"error":"Missing required parameter: endpoint"}');

if(!file_exists('./endpoints/' . $_ENDPOINT . '.php')) die('{"error":"API endpoint does not exist"}');

if($_SERVER['REQUEST_METHOD'] != 'GET') {
	$_DATA = json_decode(file_get_contents('php://input'), true);
}

require_once('./lib/database.php');

//$_SQL = new Database('192.168.109.252', 'root', 'L0cked0ut!');
//$_SQL = new Database('localhost', 'root', 'D1rtyTurb1n?');
//$_SQL = new Database('localhost', 'ucxbuilder', '?7-loWuEqHXj');

$_SQL = new Database('localhost', 'id17474761_torque', 'r4*-GLR--#O<[g|b', 'id17474761_mguy');

require_once('./endpoints/' . $_ENDPOINT . '.php');

$_RESPONSE = call_user_func($_ENDPOINT);
$_JSON = json_encode($_RESPONSE, JSON_NUMERIC_CHECK);

print($_JSON);

$_SQL->query("INSERT INTO `express_log` (`method`,`endpoint`,`ipAddress`,`userAgent`,`utc`,`request`,`response`) VALUES (
	'" . addslashes($_SERVER['REQUEST_METHOD']) . "',
	'" . addslashes($_ENDPOINT) . "',
	'" . addslashes($_SERVER['REMOTE_ADDR']) . "',
	'" . addslashes($_SERVER['HTTP_USER_AGENT']) . "',
	'" . date('Y-m-d H:i:s') . "',
	'" . addslashes(json_encode((!$_DATA ? $_GET : $_DATA))) . "',
	'" . addslashes(json_encode($_RESPONSE)) . "')");

exit;
?>