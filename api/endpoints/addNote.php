<?php
function addNote($orderId=false, $note=false) {
	if(!empty($_GET['orderId'])) $orderId = intval($_GET['orderId']);
	if(!empty($_GET['note'])) $note = urldecode($_GET['note']);

	if(!$orderId || !$note) die('{"error":"Missing required parameters (orderId, note)"}');

	$note = str_replace('+', ' ', $note);

	$curl = curl_init();

	$payload = array(
		'entityId' => $orderId,
		'noteText' => $note,
		'system' => 'UCx Builder Test',
		'userName' => 'scleaves'
	);

	curl_setopt_array($curl, array(
		CURLOPT_URL => "https://api.tpxdev.net/note/fasttrack/order",
		CURLOPT_RETURNTRANSFER => true,
		CURLOPT_ENCODING => "",
		CURLOPT_MAXREDIRS => 10,
		CURLOPT_TIMEOUT => 0,
		CURLOPT_FOLLOWLOCATION => true,
		CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
		CURLOPT_CUSTOMREQUEST => "POST",
		CURLOPT_SSL_VERIFYHOST => false,
		CURLOPT_SSL_VERIFYPEER => false,
		CURLOPT_POSTFIELDS => json_encode($payload),
		CURLOPT_HTTPHEADER => array(
			"Content-Type: application/json",
			"Authorization: Basic MUpiblJQYjhqTDhMMk9DaVM3TWI6aE9vWVRYSnBydG1hWjhVVjVkT20="
		),
	));

	$response = curl_exec($curl);

	if(curl_errno($curl)) {
		$response = curl_error($curl);
	}

	curl_close($curl);

	die($response);

	return json_decode($response);
}
?>