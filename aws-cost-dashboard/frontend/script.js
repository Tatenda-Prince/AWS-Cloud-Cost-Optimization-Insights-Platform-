async function fetchCostData() {
    const apiUrl = "https://ie9r1ho524.execute-api.us-east-1.amazonaws.com/prod/cost";  // Replace with your API Gateway URL
    
    try {
        const response = await fetch(apiUrl);
        const data = await response.json();

        // Update total cost
        document.getElementById("total-cost").textContent = data.total_cost.toFixed(2);

        // Update service costs
        const serviceCostsList = document.getElementById("service-costs");
        serviceCostsList.innerHTML = ""; // Clear previous entries

        for (const [service, cost] of Object.entries(data.service_costs)) {
            const listItem = document.createElement("li");
            listItem.textContent = `${service}: $${cost.toFixed(2)}`;
            serviceCostsList.appendChild(listItem);
        }
    } catch (error) {
        console.error("Error fetching cost data:", error);
        document.getElementById("total-cost").textContent = "Error";
        document.getElementById("service-costs").innerHTML = "<li>Failed to load data</li>";
    }
}
