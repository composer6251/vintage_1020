// BASE URLs
final String mac_studio_ip = '192.168.1.111';
final String apiBaseUrl = '$mac_studio_ip:8080';

// GET ENDPOINTS
final String apiGetAllInventoryItems = '$apiBaseUrl/inventory-items';
final String apiGetItemById = '$apiBaseUrl/inventory/get-item-by-id';
final String apiGetUserInventoryByEmail = '$apiBaseUrl/inventory/get-user-inventory';
// /inventory/get-user-inventory/{userEmail}
// POST ENDPOINTS
final String addItemUrl = '/inventory/add';
