# PersistentVolume Helm Chart

A Helm chart to create PersistentVolume (PV) resources in Kubernetes clusters.

## Overview

This chart allows you to easily create and manage PersistentVolume resources with various volume types including:
- Local volumes
- NFS volumes
- HostPath volumes

## Installing the Chart

```bash
helm install my-pv ./pv -n default
```

## Values

### PersistentVolume Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `persistentVolume.enabled` | Enable PersistentVolume creation | `true` |
| `persistentVolume.name` | Name of the PersistentVolume | `""` (uses fullname) |
| `persistentVolume.size` | Storage capacity | `1Gi` |
| `persistentVolume.accessMode` | Access mode (ReadWriteOnce, ReadOnlyMany, ReadWriteMany) | `ReadWriteOnce` |
| `persistentVolume.storageClassName` | Storage class name | `""` |
| `persistentVolume.volumeType` | Volume type (local, nfs, hostPath) | `local` |
| `persistentVolume.persistentVolumeReclaimPolicy` | Reclaim policy (Delete, Retain, Recycle) | `Retain` |
| `persistentVolume.annotations` | Annotations for the PV | `{}` |
| `persistentVolume.labels` | Labels for the PV | `{}` |

### Local Volume

| Parameter | Description | Default |
|-----------|-------------|---------|
| `persistentVolume.localPath` | Local path on the node | `/mnt/data` |
| `persistentVolume.nodeAffinity` | Node affinity rules | Node selector terms |

### NFS Volume

| Parameter | Description | Default |
|-----------|-------------|---------|
| `persistentVolume.nfs.server` | NFS server address | `""` |
| `persistentVolume.nfs.path` | NFS export path | `""` |

### HostPath Volume

| Parameter | Description | Default |
|-----------|-------------|---------|
| `persistentVolume.hostPath.path` | Host path | `/mnt/data` |
| `persistentVolume.hostPath.type` | Host path type (Directory, File, etc.) | `Directory` |

## Examples

### Local Volume with Node Affinity

```bash
helm install my-local-pv ./pv \
  --set persistentVolume.volumeType=local \
  --set persistentVolume.localPath=/data \
  --set persistentVolume.nodeAffinity.required.nodeSelectorTerms[0].matchExpressions[0].key=node-name \
  --set persistentVolume.nodeAffinity.required.nodeSelectorTerms[0].matchExpressions[0].values[0]=worker-1
```

### NFS Volume

```bash
helm install my-nfs-pv ./pv \
  --set persistentVolume.volumeType=nfs \
  --set persistentVolume.nfs.server=192.168.1.100 \
  --set persistentVolume.nfs.path=/exports/data \
  --set persistentVolume.size=100Gi
```

### HostPath Volume

```bash
helm install my-hostpath-pv ./pv \
  --set persistentVolume.volumeType=hostPath \
  --set persistentVolume.hostPath.path=/mnt/data \
  --set persistentVolume.storageClassName=fast-storage
```

## Usage with PersistentVolumeClaim

After creating the PersistentVolume, you can create a PersistentVolumeClaim:

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: my-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
  volumeName: my-pv  # Must match the PV name
```

## Uninstalling the Chart

```bash
helm uninstall my-pv
```

## License

This chart is provided as-is for use with your Kubernetes clusters.
