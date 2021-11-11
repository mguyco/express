<?php
function complete() {
	global $_DATA, $_SQL;

	$response = array();

	if(empty($_DATA['id']) || empty($_DATA['order']) || empty($_DATA['data'])) die('{"error":"Invalid request"}');

	$order = $_DATA['order'];
	$orderId = intval($order['id']);
	$data = json_encode($_DATA['data']);

	if($orderId == 0) die('{"error":"Invalid order number"}');

	$_SQL->update(
		'express_orders', array(
			'completedOnDate' => date('Y-m-d H:i:s'),
			'data' => $data
		), 
		'orderId = ' . $orderId
	);

	return array('success' => 'Express Setup has been completed');
}
?>