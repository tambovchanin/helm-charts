# PersistentVolume Helm Chart

A Helm chart to create PersistentVolume (PV) resources in Kubernetes clusters.

## Overview

This chart allows you to easily create and manage PersistentVolume resources with various volume types including:
- Local volumes
- NFS volumes
- HostPath volumes
- CSI (Container Storage Interface) volumes

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
| `persistentVolume.volumeType` | Volume type (local, nfs, hostPath, csi) | `local` |
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

### CSI Volume

| Parameter | Description | Default |
|-----------|-------------|---------|
| `persistentVolume.csi.driver` | CSI driver name (e.g., ebs.csi.aws.com, csi.vsphere.vmware.com) | `""` |
| `persistentVolume.csi.volumeHandle` | Volume handle/ID from the CSI driver | `""` |
| `persistentVolume.csi.readOnly` | Whether the volume is read-only | `false` |
| `persistentVolume.csi.fsType` | Filesystem type (e.g., ext4, xfs) | `""` |
| `persistentVolume.csi.volumeAttributes` | Additional CSI volume attributes | `{}` |

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

### CSI Volume

```bash
helm install my-csi-pv ./pv \
  --set persistentVolume.volumeType=csi \
  --set persistentVolume.csi.driver=ebs.csi.aws.com \
  --set persistentVolume.csi.volumeHandle=vol-1234567890abcdef0 \
  --set persistentVolume.csi.fsType=ext4 \
  --set persistentVolume.size=100Gi
```

### CSI Volume with Additional Attributes

```bash
helm install my-csi-pv ./pv \
  --set persistentVolume.volumeType=csi \
  --set persistentVolume.csi.driver=csi.vsphere.vmware.com \
  --set persistentVolume.csi.volumeHandle=managed-disk-id \
  --set persistentVolume.csi.volumeAttributes."folder"="/vm-folder" \
  --set persistentVolume.csi.volumeAttributes."datastore"="/datastore1"
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
