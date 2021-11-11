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
header('Access-Control-Allow-Headers: Origin, Content-Type');
header('Access-Control-Max-Age: 86400');

$headers  = "From: " . $_GET['from'] . "\r\n";
$headers .= "Reply-To: ". $_GET['from'] . "\r\n";
$headers .= "CC: " . $_GET['from'] . "\r\n";
$headers .= "MIME-Version: 1.0\r\n";
$headers .= "Content-Type: text/html; charset=ISO-8859-1\r\n";

$subject = 'TPx Order ' . $_GET['orderId'] . ' - Express Setup';

$body = file_get_contents('./template.html');

$body = str_replace('{orderId}', $_GET['orderId'], $body);
$body = str_replace('{accessCode}', $_GET['code'], $body);
$body = str_replace('{accessLink}', $_GET['id'], $body);
$body = str_replace('{expiresOnDate}', date('Y-m-d H:i', $_GET['expiration']), $body);

if(!mail($_GET['to'], $subject, $body, $headers)) {
	$response = array('error' => 'Invite failed to send');
}

else $response = array('success' => 'Invite has been sent');

print json_encode($response);

exit;
?>