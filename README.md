# Bootstrapping Cluster Essentials for VMware Tanzu

Use this project to deploy
[Cluster Essentials for VMware Tanzu](https://docs.vmware.com/en/Cluster-Essentials-for-VMware-Tanzu/index.html)
to your favorite Kubernetes cluster, without having to deal with a local installation first.

The deployment is done the Kubernetes way: a pod is responsible for downloading
bits from Tanzu Network (using your credentials), and installing everything.

No need to install anything on your local workstation.
This is great news when it comes to automating the installation of
Cluster Essentials: you're just one `kubectl apply` away from bootstraping your installation.

Or even better, with a GitOps-based approach.

## How to use it?

You obviously need a Kubernetes cluster, and the `kubectl` CLI. That's all you need.

Download the latest release archive, and unzip it:

```shell
unzip tanzu-cluster-essentials-bootstrap.zip && cd tanzu-cluster-essentials-bootstrap
```

In order to download bits from Tanzu Network, you need to provide your credentials.

Create a file `bootstrap-secrets.yaml` (starting from `bootstrap-secrets.yaml.template`),
and edit accordingly:

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: tanzu-cluster-essentials-bootstrap-credentials
  namespace: tanzu-cluster-essentials-bootstrap
type: Opaque
stringData:
  INSTALL_REGISTRY_USERNAME: johndoe@corp.com
  INSTALL_REGISTRY_PASSWORD: changeme
```

You're almost done!

Run this command to deploy Cluster Essentials to your Kubernetes cluster:

```shell
kubectl apply -f .
```

A Kubernetes `Job` is created, which will spawn a `Pod` instance taking care of the deployment.
If the deployment is successful, the `Pod` is terminated and will eventually be removed by Kubernetes.

Enjoy!

## Contribute

Contributions are always welcome!

Feel free to open issues & send PR.

## License

Copyright &copy; 2023 [VMware, Inc. or its affiliates](https://vmware.com).

This project is licensed under the [Apache Software License version 2.0](https://www.apache.org/licenses/LICENSE-2.0).
