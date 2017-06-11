function vehicleTypeForm() {
    var vehicle_type = document.getElementById("transaction_vehicle_type").value;
	if (vehicle_type==="Truck") 
		{$("#onlyTrucks").removeClass("hidden")} 
	else 
		{$("#onlyTrucks").addClass("hidden")}
}