# Helm chart for a fullstack application

## Kubeconfig

_Get available contexts_

```
kubectl config get-contexts
```

_Switch the current context_

```
kubectl config use-context <context-name>
```

_List EKS clusters_

```
aws eks list-clusters
```

_Add a new EKS cluster_

```
aws eks update-kubeconfig --name <your-cluster-name> --region <your-region>
```

_Remove a context_

```
kubectl config delete-context <context-name>
```

_Get clusters_

```
kubectl config get-clusters
```

_Remove a cluster_

```
kubectl config delete-cluster <cluster-name>
```

## Manage cluster

_Install a Helm chart (release)_

```
helm install <relase name> <chart directory>
```

_Uninstall a Helm chart (take down a release)_

```
helm uninstall <relase name>
```

_Check release history_

```
helm history <release name>
```

_Rollback a release_

```
helm rollback <release name> <revision>
```

## Debugging

_Tunnel traffic from localhost port to the svc/pod/deployment_

```
kubectl port-forward svc/<resource name> <local port>:<target port>
---
kubectl port-forward svc/dev-backend 8000:8000
kubectl port-forward svc/dev-frontend 3000:3000
```

_Shell into the pod_

```
kubectl exec <pod name> -it -- bash
```

_Investigate resource's events and manifest_

```
kubectl describe <resource name>
```

_Test the manifest output by static generation (without hitting kuberenetes API server)_

```
helm template <chart dir> --debug
```

_Test the manifest output with hitting kuberenetes API server_

```
helm install <release name> <chart dir> --dry-run --debug
```

_Watch container's logs_

```
kubectl logs -f <pod name>
```

_Watch resource status updates_

```
kubectl get <resource name> --watch
```

_Check the resource quotas for the namespace used_

```
kubectl get resourcequota -n <namespace>
```

## Resource management

_Ingress NGINX controller releases_

```
https://github.com/kubernetes/ingress-nginx/releases
```

_Ingress NGINX controller installation_

```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.11.0/deploy/static/provider/cloud/deploy.yaml
```

_Get ingress resources_

```
kubectl get all -n ingress-nginx
```

_Get ingress_

```
kubectl get ing
```

_Inspect ingress_

```
kubectl describe ing
```
