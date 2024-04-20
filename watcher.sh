##!/bin/bash

# Step 1: Define Variables
namespace="your_namespace"
deployment_name="your_deployment_name"
max_restarts=3

# Step 2: Start a Loop
while true; do
    # Step 3: Check Pod Restarts
    restarts=$(kubectl get pods -n "$namespace" -l app="$deployment_name" -o=jsonpath='{.items[*].status.containerStatuses[*].restartCount}')

    # Step 4: Display Restart Count
    echo "Current number of restarts: $restarts"

    # Step 5: Check Restart Limit
    if [ "$restarts" -gt "$max_restarts" ]; then
        # Step 6: Scale Down if Necessary
        echo "Number of restarts exceeds maximum allowed. Scaling down the deployment..."
        kubectl scale deployment "$deployment_name" --replicas=0 -n "$namespace"
        break  # Break the loop
    fi

    # Step 7: Pause
    echo "Waiting for 60 seconds before the next check..."
    sleep 60

    # Step 8: Repeat
done
