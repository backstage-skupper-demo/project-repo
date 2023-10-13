resource "kubernetes_namespace" "openshift-gitops-operator" {
  metadata {
    name = "openshift-gitops-operator"
  }
}

resource "kubernetes_manifest" "gitops_operatorgroup" {
  manifest = {
    apiVersion    = "operators.coreos.com/v1"
    kind          = "OperatorGroup"

    metadata  = {
      name      = "openshift-gitops-operator"
      namespace = "openshift-gitops-operator"
    }
  }

  depends_on = [ kubernetes_namespace.openshift-gitops-operator ]
}

resource "kubernetes_manifest" "gitops" {
  manifest = {
    apiVersion    = "operators.coreos.com/v1alpha1"
    kind          = "Subscription"
    metadata      = {
      name      = "openshift-gitops-operator"
      namespace = "openshift-gitops-operator"
    }

    spec = {
      channel             = "latest"
      installPlanApproval = "Automatic"
      name                = "openshift-gitops-operator"
      source              = "redhat-operators"
      sourceNamespace     = "openshift-marketplace"
    }
  }

  depends_on = [ kubernetes_namespace.openshift-gitops-operator ]
}

resource "kubernetes_manifest" "application_cluster_config" {
  manifest = {
    "apiVersion" = "argoproj.io/v1alpha1"
    "kind" = "Application"
    "metadata" = {
      "name" = "cluster-config"
      "namespace" = "openshift-gitops"
    }
    "spec" = {
      "destination" = {
        "namespace" = "openshift-gitops"
        "server" = "https://kubernetes.default.svc"
      }
      "project" = "default"
      "source" = {
        "helm" = {
          "parameters" = [
            {
              "name" = "baseDomain"
              "value" = var.base_domain
            },
          ]
        }
        "path" = "./demo-setup/charts/demo-setup"
        "repoURL" = "https://github.com/backstage-skupper-demo/project-repo"
        "targetRevision" = "HEAD"
      }
      "syncPolicy" = {
        "automated" = {}
        "syncOptions" = [
          "CreateNamespace=true",
        ]
      }
    }
  }

  depends_on = [ kubernetes_namespace.openshift-gitops-operator ]
}