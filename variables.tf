variable "volume" {
type = set(string)
default = [
"jenkins.qcow2",
"kubernetes.qcow2"
]
}

variable "domain" {
default = [
"jenkins",
"kubernetes"
]
}

