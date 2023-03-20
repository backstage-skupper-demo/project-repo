# Skupper Self-Service Demo

## Reset Demo Environment
1. Run `./reset.sh`
1. Show the Argo project that no namespaces exist https://openshift-gitops-server-openshift-gitops.apps.ocp-dev.cloudfirst.dev/applications/openshift-gitops/backstage-project-repo?view=tree&operation=false&conditions=false&resource=
1. Show the openshift console that the projects do not exist
https://console-openshift-console.apps.ocp-dev.cloudfirst.dev/k8s/cluster/projects?project-name=skupper-proj
1. Navigate to the configured Backtage environment
1. Create two openshift projects named
    1. skupper-proj1
    2. skupper-proj2
1. Navigate to the argo and show the projects are now there
https://openshift-gitops-server-openshift-gitops.apps.ocp-dev.cloudfirst.dev/applications/openshift-gitops/backstage-project-repo?view=tree&operation=false&conditions=false&resource=
1. Navigate to the openshift console and show that the projects are now present, then navigate to on of the project workloads and highlight that no workloads are running
https://console-openshift-console.apps.ocp-dev.cloudfirst.dev/k8s/cluster/projects?project-name=skupper-proj
1. Create a skupper project with the following
    1. Project "skupper-proj1"
    1. Site "proj1"
    1. Empty linked sites
1. Trigger the pipeline
1. run `skupper link status -n skupper-proj1` to show there are currently no links
1. Create a skupper project with the following
    1. Project "skupper-proj2"
    1. Site "proj2"
    1. Linked site "proj1"
1. Trigger the pipeline
1. Navigate to the openshift console and show the skupper is now running

1. run `skupper link status -n skupper-proj1` to highlight the link is now established
