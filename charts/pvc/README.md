# PersistentVolumeClaim Helm Chart

A Helm chart to create PersistentVolumeClaim (PVC) resources in Kubernetes clusters.

## Overview

This chart allows you to easily create and manage PersistentVolumeClaim resources. It supports both:
- **Dynamic provisioning** - automatically creates a PersistentVolume using a StorageClass
- **Static binding** - binds to an existing PersistentVolume

## Installing the Chart

### Dynamic Provisioning (Default)
```bash
helm install my-pvc ./pvc
```

### Static Binding to Existing PV
```bash
helm install my-pvc ./pvc \
  --set persistence.volumeName=my-pv \
  --set persistence.storageClass="-"
```

## Values

| Parameter | Description | Default |
|-----------|-------------|---------|
| `persistence.enabled` | Enable PVC creation | `true` |
| `persistence.volumeName` | Name of existing PersistentVolume to bind to (leave empty for dynamic) | `""` |
| `persistence.accessMode` | Access mode (ReadWriteOnce, ReadOnlyMany, ReadWriteMany) | `ReadWriteOnce` |
| `persistence.size` | Storage size | `1Gi` |
| `persistence.storageClass` | Storage class name for dynamic provisioning | `""` |
| `persistence.annotations` | Annotations for the PVC | `{}` |

## Examples

### Create PVC with Dynamic Provisioning
```bash
helm install data-pvc ./pvc \
  --set persistence.size=10Gi \
  --set persistence.storageClass=fast-ssd
```

### Create PVC Bound to Specific PV
```bash
# First, ensure the PV exists
kubectl apply -f - <<EOF
apiVersion: v1
kind: PersistentVolume
metadata:
  name: my-local-pv
spec:
  capacity:
    storage: 5Gi
  accessModes:
    - ReadWriteOnce
  local:
    path: /mnt/data
  nodeAffinity:
    required:
      nodeSelectorTerms:
      - matchExpressions:
        - key: kubernetes.io/hostname
          operator: In
          values:
          - node-1
EOF

# Then create PVC that binds to this PV
helm install data-pvc ./pvc \
  --set persistence.volumeName=my-local-pv \
  --set persistence.size=5Gi \
  --set persistence.storageClass="-"
```

### Multiple PVCs with Annotations
```bash
helm install cache-pvc ./pvc \
  --set persistence.size=20Gi \
  --set persistence.volumeName=cache-volume \
  --set persistence.annotations."description"="Cache storage"
```

## Verifying the PVC

```bash
# Check PVC status
kubectl get pvc

# View PVC details
kubectl describe pvc my-pvc

# Check PVC binding to PV
kubectl get pvc my-pvc -o jsonpath='{.spec.volumeName}'
```

## Uninstalling the Chart

```bash
helm uninstall my-pvc
```

## Important Notes

- When specifying `volumeName`, ensure:
  - The PersistentVolume with that name exists
  - The access mode matches between PVC and PV
  - The storage size requested does not exceed the PV's capacity
  - If using static binding, set `storageClass` to `"-"` to disable dynamic provisioning

- If `volumeName` is not specified, Kubernetes will automatically provision storage based on the `storageClass`

- The PVC will remain in "Pending" state until:
  - A PersistentVolume matches its requirements (for dynamic provisioning)
  - Or it successfully binds to the specified PersistentVolume

## License

This chart is provided as-is for use with your Kubernetes clusters.
