<?php
function catalog($orderId=false) {
	global $_DATA, $_SQL;

	$catalog = array();

	if(!empty($_GET['orderId'])) $orderId = intval($_GET['orderId']);

	if(!$orderId) die('{"error":"Missing required parameter: orderId"}');

	$order = $_SQL->queryData("SELECT products 
		FROM express_orders 
		WHERE orderId = '" . intval($orderId) . "'", false);

	if(empty($order['products'])) die('{"error":"Order not found"}');

	$orderProducts = json_decode($order['products'], true);
	$orderProductIds = array();

	foreach($orderProducts as $orderProduct) {
		$orderProductIds[$orderProduct['ProductID']] = array(
			'productId' => $orderProduct['ProductID'],
			'quantity' => array(
				'ordered' => $orderProduct['Qty'],
				'available' => $orderProduct['Qty'],
				'used' => 0
			)
		);
	}

	$query = $_SQL->query("SELECT 
		c.name,
		c.key,
		p.catalogId AS id,
		p.productId,
		p.product
		FROM express_products AS p
		LEFT JOIN express_catalogs AS c ON p.catalogId = c.id  
		WHERE p.active = 1 
		AND c.active = 1");

	while($row = $query->fetch_assoc()) {
		if(!array_key_exists($row['productId'], $orderProductIds)) continue;

		$orderProduct = $orderProductIds[$row['productId']];

		$row['product'] = array_merge(json_decode($row['product'], true), $orderProduct);

		if(!array_key_exists($row['key'], $catalog)) $catalog[$row['key']] = array();

		$catalog[$row['key']][] = $row['product'];
	}

	return $catalog;
}
?>