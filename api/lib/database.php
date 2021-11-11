<?php
class Database {
	private $hostname;
	private $username;
	private $password;
	private $database;
	private $conn;
	private $query;

	function __construct($hostname, $username, $password, $database=false) {
		$this->hostname = $hostname;
		$this->username = $username;
		$this->password = $password;

		$this->conn = new mysqli(
			$this->hostname, 
			$this->username, 
			$this->password
		) or die('{"error":"Failed to connect to hostname: ' . $hostname . '"}');

		if($database !== false) {
			$this->database = $database;

			$this->conn->select_db($this->database);
		}

		return $this->conn;
	}

	public function query($sql) {
		$query = $this->conn->query($sql) or die('{"error":"' . $this->conn->error . ': ' . $sql . '"}');

		return $query;
	}

	public function insertId() {
		return $this->conn->insert_id;
	}

	public function affectedRows() {
		return $this->conn->affected_rows;
	}

	public function insert($table, $data) {
		$values = array_values($data);
		$keys = array_keys($data);
		$count = 0;

		$sql = "INSERT INTO " . $table . " (" . implode(',', array_keys($data)) . ") VALUES (";

		foreach($values as $val) {
			$val = $this->conn->real_escape_string($val);

			$sql .= ($count > 0 ? ',' : '') . ($val == null ? 'NULL' : "'" . $val . "'");

			$count++;
		}

		return $this::query($sql . ')');
	}

	public function update($table, $data, $condition) {
		$sql = "UPDATE " . $table . " SET ";
		$count = 0;

		foreach($data as $key=>$val) {
			$val = $this->conn->real_escape_string($val);
			
			$sql .= ($count > 0 ? ',' : '') . $key . " = " . ($val == null ? 'NULL' : "'" . $val . "'");

			$count++;
		}

		$sql .= ' WHERE ' . $condition;

		return $this::query($sql);
	}

	public function delete($table, $condition) {
		return $this::query("DELETE FROM " . $table . " WHERE " . $condition);
	}

	public function queryData($sql, $returnArray=true) {
		$query = $this::query($sql) or die('{"error":"' . $this->conn->error . ': ' . $sql . '"}');

		$data = array();

		while($row = $query->fetch_assoc()) {
			$row = array_map('utf8_encode', $row);

			$data[] = $row;
		}

		if(count($data) == 1 && !$returnArray) return $data[0];
		else return $data;
	}
}
?>