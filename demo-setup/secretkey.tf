resource "kubernetes_namespace" "skupper" {
  metadata {
    name = "skupper"
  }
}

resource "kubernetes_secret" "ssh-key" {
  metadata {
    name      = "vm-ssh-key"
    namespace = "skupper"
  }

  data = {
    ssh-key = tls_private_key.skuppervm.private_key_openssh
  }

  depends_on = [ kubernetes_namespace.skupper ]
}