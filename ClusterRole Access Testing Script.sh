#!/bin/bash

# Cluster-wide resources to test
RESOURCES=("nodes" "namespaces" "persistentvolumes")
VERBS=("get" "list" "watch" "create" "update" "delete")
USERS=("john" "dave" "admin")

echo "🔎 Testing cluster-wide RBAC permissions..."

for user in "${USERS[@]}"; do
  echo -e "\n🔍 Testing access for user: $user"
  for resource in "${RESOURCES[@]}"; do
    for verb in "${VERBS[@]}"; do
      echo -n "Can $user $verb $resource? → "
      kubectl auth can-i "$verb" "$resource" --as="$user"
    done
  done
  echo "-------------------------------------------"
done
