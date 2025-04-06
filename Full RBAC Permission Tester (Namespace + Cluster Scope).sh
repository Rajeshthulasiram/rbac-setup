#!/bin/bash

# === CONFIG ===
NAMESPACE="rajesh-app"
USERS=("john" "dave" "admin")
NS_RESOURCES=("pods" "deployments" "services")
CLUSTER_RESOURCES=("nodes" "namespaces" "persistentvolumes")
VERBS=("get" "list" "watch" "create" "update" "delete")

echo "🚀 Starting RBAC Permission Test"
echo "Namespace: $NAMESPACE"
echo "Users: ${USERS[*]}"
echo "---------------------------------------------"

for user in "${USERS[@]}"; do
  echo -e "\n👤 User: $user"

  # Namespace-level access
  echo "🔹 Namespace-scoped checks (namespace: $NAMESPACE):"
  for res in "${NS_RESOURCES[@]}"; do
    for verb in "${VERBS[@]}"; do
      echo -n "  Can $user $verb $res? → "
      kubectl auth can-i "$verb" "$res" -n "$NAMESPACE" --as="$user"
    done
  done

  # Cluster-level access
  echo "🔸 Cluster-wide checks:"
  for res in "${CLUSTER_RESOURCES[@]}"; do
    for verb in "${VERBS[@]}"; do
      echo -n "  Can $user $verb $res (cluster)? → "
      kubectl auth can-i "$verb" "$res" --as="$user"
    done
  done

  echo "✅ Done testing user: $user"
  echo "---------------------------------------------"
done

echo "🎉 All checks complete!"
