variable "cloud_id" {
    description = "yandex cloud id"
    type = string
    default = "b1gnou8ef102naulbkft"
}

variable "folder_id" {
    description = "yandex folder id for cluster creation"
    type = string
    default = "b1goc84dkn0fu8qos7eu"
}

variable "service_account_key_file" {
    description = "Path to key file for service account which will be used by terraform yandex-cloud provider"
    type = string
    default = "authorized_key.json"
}

variable "zone" {
    type = string
    default = "ru-central1-a"
}

variable "k8s_version" {
    default = 1.22
}

variable "sa_name" {
    description = "Name of a service account to use/create for cluster management needs"
    default = "k8s-cluster-manager-sa"
}

variable "node_count" {
    type = number
    description = "number of worker-nodes to maintain"
    default = 1
}