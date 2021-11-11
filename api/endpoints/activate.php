<?php
function activate() {
	global $_DATA, $_SQL;

	$response = array();

	if(empty($_DATA['id']) || empty($_DATA['accessCode'])) die('{"error":"Invalid request"}');

	$sql = "SELECT id 
	FROM express_invites 
	WHERE MD5(CONCAT(accessCode, generatedOnDate, orderId)) = '" . addslashes($_DATA['id']) . "'
	AND accessCode = '" . addslashes($_DATA['accessCode']) . "' LIMIT 1";

	$data = $_SQL->queryData($sql, false);

	if(empty($data['id'])) return array('error' => 'Invalid access code');
	else {
		$date = date('Y-m-d H:i:s');

		$response = array(
			'id' => $_DATA['id'],
			'ipAddress' => (empty($_SERVER['REMOTE_ADDR']) ? '' : $_SERVER['REMOTE_ADDR']),
			'host' => (empty($_SERVER['REMOTE_HOST']) ? '' : $_SERVER['REMOTE_HOST']),
			'browser' => (empty($_SERVER['HTTP_USER_AGENT']) ? '' : $_SERVER['HTTP_USER_AGENT']),
			'referer' => (empty($_SERVER['HTTP_REFERER']) ? '' : $_SERVER['HTTP_REFERER'])
		);

		$_SQL->update('express_invites', array(
			'activatedOnDate' => $date,
			'response' => json_encode($response)
		), 'id = ' . $data['id']);

		return array('success' => 'Express Setup has been activated');
	}
}
?>