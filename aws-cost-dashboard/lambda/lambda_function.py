import boto3
import datetime
import json

def lambda_handler(event, context):
    client = boto3.client('ce')

    # Get the current date
    end_date = datetime.date.today().strftime("%Y-%m-%d")
    start_date = (datetime.date.today() - datetime.timedelta(days=7)).strftime("%Y-%m-%d")

    # Fetch cost data grouped by service
    response = client.get_cost_and_usage(
        TimePeriod={"Start": start_date, "End": end_date},
        Granularity="DAILY",
        Metrics=["UnblendedCost"],
        GroupBy=[{"Type": "DIMENSION", "Key": "SERVICE"}]  # Group by AWS service
    )

    # Initialize cost summary
    total_cost = 0.0
    service_costs = {}

    # Process response to structure data
    for result in response.get("ResultsByTime", []):
        for group in result.get("Groups", []):
            service_name = group["Keys"][0]  # Extract service name
            cost = float(group["Metrics"]["UnblendedCost"]["Amount"])  # Convert cost to float
            
            if service_name in service_costs:
                service_costs[service_name] += cost  # Accumulate cost per service
            else:
                service_costs[service_name] = cost
            
            total_cost += cost  # Sum total cost

    # Prepare response in required format
    formatted_response = {
        "total_cost": round(total_cost, 2),
        "service_costs": {k: round(v, 2) for k, v in service_costs.items()}
    }

    # Log the response
    print(json.dumps(formatted_response, indent=2))

    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json",
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Methods": "GET, POST, OPTIONS",
            "Access-Control-Allow-Headers": "Content-Type"
        },
        "body": json.dumps(formatted_response)
    }
