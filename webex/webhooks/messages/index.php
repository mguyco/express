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

require_once('./../../../api/lib/database.php');

$DB = new Database('localhost', 'root', 'D1rtyTurb1n?');

if($_SERVER['REQUEST_METHOD'] != 'POST') die('Not Allowed');

if(!empty($_POST['data'])) {
	$DB->insert('webex.webhooks', array('data' => json_encode($_POST)));
}

exit;
?>