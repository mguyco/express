<?php
function validate() {
	global $_DATA, $_SQL;

	$response = array();

	$id = (empty($_GET['id']) ? false : urldecode($_GET['id']));

	if(!$id) return array(
		'error' => 'Express Setup link not found'
	);

	$sql = "SELECT 
		i.orderId,
		i.account,
		i.expiresOnDate,
		i.activatedOnDate,
		o.products,
		o.numbers AS phoneNumbers,
		o.data AS customer 
		FROM express_invites AS i 
		LEFT JOIN express_orders AS o USING (orderId) 
		WHERE MD5(CONCAT(i.accessCode, i.generatedOnDate, i.orderId)) = '" . addslashes($id) . "'";

	$data = $_SQL->queryData($sql, false);

	if(empty($data['orderId'])) return array(
		'error' => 'Express Setup link could not be validated'
	);

	if($data['activatedOnDate'] == '' && (time() > strtotime($data['expiresOnDate'] . ' UTC'))) return array(
		'error' => 'Express Setup link has expired'
	);

	$data['products'] = json_decode($data['products']);
	$data['account'] = json_decode($data['account']);
	$data['phoneNumbers'] = json_decode($data['phoneNumbers']);
	$data['customer'] = json_decode($data['customer']);

	// product catalog
	include('./endpoints/catalog.php');

	$data['catalog'] = catalog($data['orderId']); // query catalog using orderId

	$_SQL->update(
		'express_orders', 
		array('visitedOnDate' => date('Y-m-d H:i:s')),
		"orderId = '" . intval($data['orderId']) . "'"
	);

	return $data;
}
?>